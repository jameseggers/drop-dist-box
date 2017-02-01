# Project Report

The high level aim of this project was to create a distributed file storage service which can store files on different nodes in a secure way and then retrieve them for a user. User Interfaces for adding users and adding permissions which govern what files different users can access are also provided. Below is a description of the different sub-services in the project and how they are implemented.

---

#### Technical Overview
The Project is implemented using the Ruby on Rails Web Development Framework, and uses PostgreSQL as a database. It stores references to files in the database and the files themselves in the normal file system.

Each file uploaded should be replicated on each node. Each node knows about all the other storage nodes in the cluster, and it uses Sidekiq to que jobs which upload the file to each node.

The system uses the [JWT Ruby Gem](https://github.com/jwt/ruby-jwt) which is _open source_ to enforce a measure of security, detailed more below.

---

#### General Overview

##### Home Screen
![image](https://s3-eu-west-1.amazonaws.com/dist-report/home-screen.png)

The Home Screen lists all files currently available for the logged in user.

1. The user can click **show** to view more details about a file.
2. The user can click **edit** to edit the file name or other details.
3. The user can click **destroy** to remove the file from all nodes in the cluster.

To store and manage the attachments in the Rails app, the [Paperclip](https://github.com/thoughtbot/paperclip) _open-source_ gem was used.

##### Show File Screen
![image](https://s3-eu-west-1.amazonaws.com/dist-report/file-show-screen.png)

When a user clicks into a file, the system shows the image by itself accompanied by other relevant details such as the name. The user can choose to **edit**, or **download** the file.

Upon clicking **download**, the system uses a **round-robin** style approach to find a node in the cluster with the file available, and redirects the user to the correct address to download the requested file.
