# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#Users seed
User.create(
:name => "user1" ,
:email => "hoge@hoge.com" ,
:admin => false ,
:gender => 1 ,
:height => 180 ,
:age => 22 )

User.create(
:name => "user2" ,
:email => "hoge@hoge.com" ,
:admin => false ,
:gender => 1 ,
:height => 180 ,
:age => 22 )
