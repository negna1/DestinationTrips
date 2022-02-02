from datetime import date
from flask import Flask
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from ariadne import load_schema_from_path, make_executable_schema, \
    graphql_sync, snake_case_fallback_resolvers, ObjectType, convert_kwargs_to_snake_case
from ariadne.constants import PLAYGROUND_HTML
from flask import request, jsonify

app = Flask(__name__)
CORS(app)

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///destionations.db?check_same_thread=False'
db = SQLAlchemy(app, session_options={"autoflush": True})

class Destination(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String)
    description = db.Column(db.String)
    created_at = db.Column(db.Date)
    def to_dict(self):
        return {
            "id": self.id,
            "title": self.title,
            "description": self.description,
            "created_at": str(self.created_at)
        }

def listPosts_resolver(obj, info):
    posts = [post.to_dict() for post in Destination.query.all()]
    print(posts)
    try:
        posts = [post.to_dict() for post in Destination.query.all()]
        print(posts)
        payload = {
            "success": True,
            "destination": posts
        }
    except Exception as error:
        payload = {
            "success": False,
            "errors": [str(error)]
        }
    return payload

@convert_kwargs_to_snake_case
def getPost_resolver(obj, info, id):
    try:
        post = Destination.query.get(id)
        print(post.to_dict())
        payload = {
            "success": True,
            "destination": post.to_dict()
        }
    except AttributeError:  # todo not found
        payload = {
            "success": False,
            "errors": ["Post item matching {id} not found"]
        }
    return payload

@convert_kwargs_to_snake_case
def create_destination_resolver(obj, info, title, description):
    try:
        today = date.today()
        post = Destination(
            title=title, description=description, created_at=today
        )
        db.session.add(post)
        db.session.commit()
        payload = {
            "success": True,
            "destination": post.to_dict()
        }
    except ValueError:  # date format errors
        payload = {
            "success": False,
            "errors": [f"Incorrect date format provided. Date should be in "
                       f"the format dd-mm-yyyy"]
        }
    return payload

@convert_kwargs_to_snake_case
def remove_resolver(obj, info, title, description):
    try:
        Destination.query.filter(Destination.title == title and Destination.description == description ).delete()
        db.session.commit()
        payload = {
            "success": True,
        }
    except ValueError:  # date format errors
        payload = {
            "success": False,
            "errors": [f"Incorrect date format provided. Date should be in "
                       f"the format dd-mm-yyyy"]
        }
    return payload

@app.route('/')
def hello():
    return 'My First API !!'

query = ObjectType("Query")
mutation = ObjectType("Mutation")
query.set_field("listDestinations", listPosts_resolver)
query.set_field("getDestination", getPost_resolver)
mutation.set_field("createDestination", create_destination_resolver)
mutation.set_field("removeDestination", remove_resolver)

type_defs = load_schema_from_path("schema.graphql")
schema = make_executable_schema(
    type_defs, query, mutation, snake_case_fallback_resolvers
)
@app.route("/graphql", methods=["GET"])
def graphql_playground():
    return PLAYGROUND_HTML, 200

@app.route("/graphql", methods=["POST"])
def graphql_server():
    data = request.get_json()
    success, result = graphql_sync(
        schema,
        data,
        context_value=request,
        debug=app.debug
    )
    status_code = 200 if success else 400
    return jsonify(result), status_code