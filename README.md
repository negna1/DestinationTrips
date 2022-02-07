# DestinationTrips
<p align="center">


## Main Usage
DestinationTrips is application  that allows you to manage your trips, what do you like, what you not.

# Build projects

There are two kind of project.

### API

Api is written with flask, flask database ,Graphgql and python.
flask database is easy to create, because it has general class as table models. 
There is database which is already created (new_calories), but it is possible to change database.

* In API project  `app.py`  file there is  `app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///destinations.db?check_same_thread=False'` which is for to create new database. 
* open terminal or command line (if it isn't pythons than run with python) 
* run   `from app import db ` and if you want to use anything you must import first
* run `db.session.create_all()`
* than rund app.py and it creates database
* * To add new model   `db.session.add(model)`
*  * and commit to add that `db.session.commit()`
  
### Run API

To run api it is important to run app.py, Than it will be run on localhost, if disconnect that services not countinue working.


```
deployment target is 15.2 that's why it need xcode 13, but it is possible to low down version from target file.
To install pod run 
```bash
$ pod install
```
in directory where podfile is. 
 
 Theres is only creation for destination (but service of remove already is written), theres favourite and disliked lists.
  
