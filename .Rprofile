# #2021-09-27 (.Rprofile) [3/3] Location: "./../Z14_R4DS"=====================================#
# #This file is Not auto-executed. It is sourced by [2/3] & thus executes on "^+F10" "AHK F5"

# [1] Location: Sys.getenv("HOME") - 
#	This is kept in USER HOME and changed only when USER is changed.
#	This File is Auto-executed on Start-up & on RStudio Restart R i.e. "^+F10" "AHK F5"
#	To change the working directory "D:/Analytics/R"
#	Execute the .Rprofile [2/3] (No Auto-execution)
# [2] Location: "D:/Analytics/R"
#	To Point to the Latest Project as working directory 
#	Execute the .Rprofile [3/3] (No Auto-execution) 
# [3] Location: Working Directory
# Advantage is that every project has its own .Rprofile, thus it can keep its own changes.
# Specially, with GIT initialisation, it can be kept in sync with the project files.
# This file is executed when RStudio opens a project or a file in the directory.

# #Set a CRAN mirror. Change the Target URL to the one having 'https' to avoid warnings.
local({r <- getOption("repos")
       r["CRAN"] <- "https://cloud.r-project.org/"
       options(repos=r)})

# #Modify Library Path
# #Note that only directories that exist at the time will be included.
if (!identical(.libPaths()[1], "C:/Softwares/R/LibFiles")) {
  .libPaths( c( "C:/Softwares/R/LibFiles", .libPaths()) )
}

# #To only download binaries and avoid 'latest code' type Errors in Windows.
options(pkgType = "binary")

# #Maximum Print Limit (Not lines, Characters. So, higher number is used.)
options(max.print=1000)

# #Set NPP as the external editor
options(editor = "C:/Program Files (x86)/Notepad++/notepad++.exe")

# #Change Prompt
options(prompt="> ")

# #Change the continuity prompt from (+), like (>), to wider (...) like Python
options(continue="... ")

# #Setup Max Width
options(width = 100)

# #Avoid GUI Dialogs in R (as implemented in RStudio)
options(menu.graphics=FALSE)

# #Form Feed Character (="\f" ="\014" ="^l") To suppress R Welcome Message (works for RStudio)
cat("\f")

# #Instruct R to, before anything else, echo a timestamp to the console and to '.Rhistory'
# #Load "utils" package for Sys.time()
library("utils")
.First <- function(){
  if(interactive()){
    message("# ### \"", getwd(), "\" ", Sys.time(), " #")
  }
}

#Hidden namespace to save objects & functions from "rm(list=ls())" 
.z <- new.env()
attach(.z)

# #Object containing PATH to R Scripts
.z$RX <- paste0(getwd(), "/code/")

# #Object containing PATH to DATA
.z$XL <- paste0(getwd(), "/data/")

# #Object containing PATH to Images
.z$PX <- paste0(getwd(), "/images/")

# #Object to decide Z-Execution. TRUE = Execute Z. (FALSE or NULL = DON'T)
.z$ZZ <- TRUE

# #tidyverse lifecycle package, to convert deprecated warnings to errors
options(lifecycle_verbosity = "error")