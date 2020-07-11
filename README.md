#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#                                                          
#    ##   ####   #####   ##      #####    ###   ##   ##    
#    ##   ## ##  ##      ##      ##       ## #  ##   ##      
#    ##   ####   ###     ##      ###      ##  # ##   ##    
#    ##   ## ##  ##      ##      ##       ##   ###   ##    
#    ##   ####   #####   #####   #####    ##   ###   ##    
#                                                          
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Author: Belén García-Cárceles                            
# https://ibeleni.com/about-2/                                      
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# repdwn
BulkDownload_PDF

# Introduction

The method described here provides a tool to download all available PDF reports about COVID-19 pandemic updates in the Ministry of Health in Spain's website.

The amount of reports available is over 120 and are updated daily.

Information in those reports are important to complement avaible data sets.

# Description

The method is developed as follows:


1. It sets the local path to store the files.
2. Looks for the logfile to check fro previous downloads.

    2.1. When executed the first time it will download all available files.
    
    2.2. When executed on the next day, it will download only new reports if they are available.

3. Download the files in the specific folder.
4. Updates the logfile.

# Docummentation
https://rpubs.com/IbelenI/redpwn


