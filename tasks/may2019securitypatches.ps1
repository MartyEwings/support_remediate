#!/bin/sh

# Puppet Task Name: may2019securitypatches
#
# This is where you put the shell code for your task.
#
# You can write Puppet tasks in any language you want and it's easy to
# adapt an existing Python, PowerShell, Ruby, etc. script. Learn more at:
# https://puppet.com/docs/bolt/0.x/writing_tasks.html
#
# Puppet tasks make it easy for you to enable others to use your script. Tasks
# describe what it does, explains parameters and which are required or optional,
# as well as validates parameter type. For examples, if parameter "instances"
# must be an integer and the optional "datacenter" parameter must be one of
# portland, sydney, belfast or singapore then the .json file
# would include:
#   "parameters": {
#     "instances": {
#       "description": "Number of instances to create",
#       "type": "Integer"
#     },
#     "datacenter": {
#       "description": "Datacenter where instances will be created",
#       "type": "Enum[portland, sydney, belfast, singapore]"
#     }
#   }
# Learn more at: https://puppet.com/docs/bolt/0.x/writing_tasks.html#ariaid-title11
#

#https://www.powershellgallery.com/packages/PSWindowsUpdate/1.5.2.2/Content/Get-WUInstall.ps1
#Requires powershell v3 but Compatible Version Windows 8, server 2012 and later as ps v3 is included by default
 

Install-Module PSWindowsUpdate -force
$KBList = "KB4499179","KB4499154","KB4494440","KB4499171","KB4499167","KB4499181","KB4499165","KB4499151","KB4499158","KB4494441"
Get-WUInstall -KBArticleID $KBList -AcceptAll
