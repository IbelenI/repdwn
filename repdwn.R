

# Scirpt version 0.1
# 8th July 2020

#Dependencies:
library(anytime) #v0.3.7
library(lubridate) #v1.7.8

#Local Path must be set here:
loca <- getwd()

# According to source, reports are updated 
# each day 14:00 CEST (UTC+2).
# Program will check the source at 20:00 CEST (UTC+2).
# On 10 Jul 2020 first available report is 21
# last available report is 159.
# Since report number 21, they are located in this URL
# respecting the same structure.
# There are changes in file name pattern (see problems below).


# First and last report available will be 21 and 159,
# respectively if it is first run,
# otherwise will use the information
# in the "updatelog.txt" file.

# The method checks for file 
# "updatelog.txt" in the path
if (length ( list.files(loca, "updatelog"))==0) {
  
  # If there is no "updatelog" file
  # this is a first run, we set the
  # default/users values.
  frst = 21
  last = 159
  # sdat = date ()
  
} else { #needs improvement.
  
  # If there is "updatelog" file
  # this is un update. Check the log.
  upnum <- read.table (paste0(loca, "updatelog.txt"), header = T)
  sel   <- which (upnum$date==max(upnum$date))
  frst  <- upnum$numrep[sel]+1
  numd  <- as.numeric(as_date(anytime(date())) - as_date(anytime (upnum$date [sel])))
  last  <- upnum$numrep[sel] + numd
}



# URL location structure is composed 
# of three variables [urlfix]+[ffix]=[rest]

# "urlfix" contains the report folder's URL
# "ffix" it the name of the folder which varies
# on each report update.
# "rest" is the file URL which is urlfix+ffix.

# Probelems:
# Problem1, two files different names patter:
# Report 44 "Actualizacion_44_COVID_1200.pdf"
# Report 45 "Actualizacion_45_COVID.pdf"
# Problem2, report 21 to 30 different name pattern:
# "Actualizacion_30_COVID-19_China.pdf"

# Method to download new reports:

urlfix = "https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov-China/documentos/"


# The number of reports to be downloaded.
# If the resulting interval contains the "problematic"
# reports (44 and 45), the method will take them out and
# download them.
reports <- c(frst:last) #needs improvement.

if (frst-last==0){
  ffix <- paste0 ( "Actualizacion_", last ,"_COVID-19_China.pdf" )
  to   <- paste0 ( loca, last,".pdf" )
  
  download.file (rest, to,
                 quiet = T,
                 mode = "wb" )
}else{
  # Solution to problem1:
  if (sum (1*(reports%in%c(44,45)>0))>0){      
    reports <- reports [- which (reports%in%c(44,45))]
    
    # Special cases, if the sequence include report 44:
    if (sum (1*(reports%in%c(44))>0)>0){
      download.file (paste0(
        urlfix,
        "Actualizacion_44_COVID_1200.pdf"), 
        paste0 ( loca, 44,".pdf" ),
        mode = "wb" 
      )
    }
    
    # Special cases, if the sequence include report 45:
    if (length (1*reports%in%c(45))>0){
      download.file (paste0(
        urlfix,
        "Actualizacion_45_COVID.pdf"), 
        paste0 ( loca, 45,".pdf" ),
        mode = "wb" 
      )
    } 
  }
  
  
  # Bulk download:
  for (i in reports) {
    # Variables:
    ffix <- paste0 ( "Actualizacion_", i,"_COVID-19.pdf" )
    
    # Solution to Problem2.
    if (i %in% c(21:30)){
      ffix <- paste0 ( "Actualizacion_", i,"_COVID-19_China.pdf" )
    }
    rest <- paste0 ( urlfix, ffix )
    to   <- paste0 ( loca, i,".pdf" )
    
    # Method:
    download.file (rest, to,
                   # quiet = T,
                   mode = "wb" )
  }
}




#Update log file to be used on following updates
logdate <- data.frame (
  numrep = last, #needs improvement.
  date = date())

if (length ( list.files(loca,
                        "updatelog"))==0) {
  write.table (logdate, 
               paste0(loca, "updatelog.txt"),
               sep = "\t", row.names=F)
}else{
  
  write.table (logdate, 
               paste0(loca, "updatelog.txt"),
               sep = "\t", row.names=F,
               col.names = F, append = T)
}


print (paste("S'han descarregat",
             last-frst+1,
             "arxius PDF (",
             last-frst+1,"PDF files downloaded)"))