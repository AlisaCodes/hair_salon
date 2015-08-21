Hair Salon
Manages the inputs of stylists and clients as well as there associations.

By Alisa Colon

Description

With this app, a salon owner has the abilty to add clients and stylists to a list, associate clients with a stylist, as well as update and delete information about the clients and stylists.

Setup

Clone from github
In PSQL:
CREATE DATABASE hair_salon;
CREATE TABLE stylists (id serial PRIMARY KEY, name varchar, specialty varchar);
CREATE TABLE clients (id serial PRIMARY KEY, client_name varchar, phone_number varchar, stylist_id int);
In command line : ruby app.rb
In browser URL : localhost:4567
Technologies Used

Ruby and SQL

Legal

Copyright (c) 2015 Alisa Colon

This software is licensed under the MIT license.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
