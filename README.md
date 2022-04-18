# CLI

#### This repository contains a CLI application to create agendas.

#### With this application you can:

1. Create different kinds of agendas.
1. Add/Search/Delete users.

### How to start the program.

1. You need to clone the [repository](https://github.com/michelbernils/cli-scheduler.git).
1. Run the command ```bundle install```
1. Now we are ready to start.

## How to use it?

The application revolves around the use of Thor gem, you can check its website [here](http://whatisthor.com/). 

So the first thing you should do is start the agenda you want. 

````
 thor cli:start_agenda agenda.csv
````

here we are starting an agenda called agenda.csv, with `name` and `email` as headers.

Obs: you have to specify the file type, here we are using the .csv.

```
thor cli:add_contact agenda michel xpto@gmail.com
```

with the agenda.csv file created, you can now start adding your contacts.

````
 thor cli:search_contact agenda.csv michel
 thor cli:delete_contact agenda.csv michel
````

with contacts added you can search and delete contacts.


## Tests? We have tests here.

In this application we use [Minitest gem](https://github.com/seattlerb/minitest). 

just run the file on the test folder. 

```
 ruby test_agenda.rb 
 ruby test_contacts.rb
```
