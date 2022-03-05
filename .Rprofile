# #(.Rprofile) [3/3] =============================================================================#
# #This file is Not auto-executed. It is sourced by [2/3] & thus executes on Restart R
# [1] Location: Sys.getenv("HOME") -
#	This is kept in USER HOME and changed only when USER is changed.
#	This File is Auto-executed on Start-up & on RStudio Restart R
#	To change the working directory to "D:/Analytics/R"
#	To execute the .Rprofile [2/3] (No Auto-execution)
# [2] Location: "D:/Analytics/R"
#	To point to the latest project as working directory
#	To execute the .Rprofile [3/3] (No Auto-execution)
# [3] Location: Working Directory
# Advantage is that every project has its own .Rprofile, thus it can keep its own changes.
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

# #Disable Scientific Notation because p-values, residuals etc. are irritating to convert
# #It might show many trailing zeroes but that can be handled separately.
#options(scipen = 0, digits = 7) #Default
options(scipen = 999)

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

# #tidyverse lifecycle package, to convert deprecated warnings to errors
options(lifecycle_verbosity = "error")

# #Warning: To upgrade Warning to Error for easy identification of problem chunk
# #Restore default: options(warn=0, error=NULL)
if(FALSE) options(warn = 2, error = recover)