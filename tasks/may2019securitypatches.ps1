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
 
try {
    $psVersion = $PSVersionTable.PSVersion
    } catch {
      $psVersion = $null
    }
    
    if(($psVersion -ne $null) -or ($psVersion.Major -gt 2)) { 
    
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Install-Package -Name PSWindowsUpdate -Force
    Import-Module PSWindowsUpdate
    Get-WUServiceManager

        $KBList = "KB4499179","KB4499154","KB4494440","KB4499171","KB4499167","KB4499181","KB4499165","KB4499151","KB4499158","KB4494441"

        Get-WUList | % {
           if ($KBList.Contains($_.KB)) {
             Get-WUInstall -KBArticleID $_.KB -AcceptAll -IgnoreReboot
           } 
        }
    } else {

        $Source="https://gallery.technet.microsoft.com/scriptcenter/2d191bcd-3308-4edd-9de2-88dff796b0bc/file/41459/43/PSWindowsUpdate.zip"
        $Destination = "c:\temp\PSWindowsUpdate.zip"
        $UnzipTo = "c:\temp"
        $PSModulePath="$env:windir\System32\WindowsPowerShell\v1.0\Modules"
        
        If ( test-path -path "c:\temp"){}else{ mkdir "c:\temp" }
        
        Invoke-WebRequest $Source -OutFile $Destination -Verbose
         
        #Function to unzip the PSWindowsUpdate.zip 
        function unzip($file, $destination)
         {
         $shell = new-object -com shell.application
         $zip = $shell.NameSpace($file)
         
         foreach($item in $zip.items())
            {
                $shell.Namespace($destination).copyhere($item)
            }
         }
         
        #Unzip the PSWindowsUpdate.zip to CC:\temp to "$env:windir\System32\WindowsPowerShell\v1.0\Modules"
        unzip -file $Destination -destination $UnzipTo 
         
        #Copy all the files from PSWindowsUpdate to 
        if(Test-Path "$PSModulePath\PSWindowsUpdate"){}else{Copy-Item -Recurse $UnzipTo\PSWindowsUpdate -Destination $PSModulePath}
        
        #Import the PSWinodwsUpdate Module 
        Import-Module PSWindowsUpdate
         
        #Get the Update server 
        Get-WUServiceManager 
        #Check, Download and Install Update 
        #You will need to run this few time to ensure that there is no more update 
        $KBList = "KB4499179","KB4499154","KB4494440","KB4499171","KB4499167","KB4499181","KB4499165","KB4499151","KB4499158","KB4494441"
        Get-WUList | % {
            if ($KBList.Contains($_.KB)) {
              Get-WUInstall -KBArticleID $_.KB -AcceptAll -IgnoreReboot
            } 
         }
    }
