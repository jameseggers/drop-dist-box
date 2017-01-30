# Project Report

The high level aim of this project was to create a distributed file storage service which can store files on different nodes in a secure way and then retrieve them for a user. User Interfaces for adding users and adding permissions which govern what files different users can access are also provided. Below is a description of the different sub-services in the project and how they are implemented.

## Technical Overview
The Project is implemented using the Ruby on Rails Web Development Framework, and uses PostgreSQL as a database. It stores references to files in the database and the files themselves in the normal file system.

Each file uploaded should be replicated on each node. Each node knows about all the other storage nodes in the cluster, and it uses Sidekiq to que jobs which upload the file to each node. 
