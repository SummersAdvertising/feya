# coding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = Admin.create :username => "管理者", :email => "admin@summers.com.tw", :password => "123", :password_confirmation => "123"

Instruction.create :name => '專業美容證照', :description => '霏亞美容證照班通過率全國第一，重視實務，經驗豐富，教程標準統一，霏亞專業美容證照班系列與您共創美好未來。'
Instruction.create :name => '美容美體實務', :description => '霏亞美容證照班通過率全國第一，重視實務，經驗豐富，教程標準統一，霏亞專業美容證照班系列與您共創美好未來。'
Instruction.create :name => '國際時尚造型', :description => '霏亞美容證照班通過率全國第一，重視實務，經驗豐富，教程標準統一，霏亞專業美容證照班系列與您共創美好未來。'
