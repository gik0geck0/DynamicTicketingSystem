# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Statuses that would represent a typical development work flow
Statuses.create([
                { :name => 'Assigned' },
                { :name => 'In Development' },
                { :name => 'Development Completed' },
                { :name => 'In Testing' },
                { :name => 'Testing Completed' },
                { :name => 'Closed' }
])
