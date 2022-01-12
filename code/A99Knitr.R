# # source(paste0(.z$RX, "A99Knitr", ".R")) ======================================================#

if (!("k_start" %in% ls(envir = .GlobalEnv))) {
# #Compile Start Time 
  k_start <- Sys.time()
# #It will be run only once while building Book or Chapter (ensured by IF block, not by 'setup')
  knitr::opts_chunk$set(include = TRUE,
                        echo = TRUE,
                        eval = TRUE,
                        collapse = TRUE,
                        cache = TRUE, autodep = TRUE, cache.comments = FALSE, 
						#cache.extra = Sys.Date(), 
                        #dev = "png",
						dev.args = list(png = list(type = "cairo")),
                        dpi = 300,
                        opts.label='twofig',
                        message = FALSE, warning = FALSE, error = FALSE,
                        progress = FALSE, verbose = FALSE
                        )			
# #Store the RunTime of slow Chunks
  k_all_chunk_times_lt <- list()  
  knitr::knit_hooks$set(chunk_run_time = local({
    now <- NULL
    function(before, options) {
      if (before) {
# #record the current time before each chunk using "<<-"
        now <<- Sys.time()
      } else {
# #calculate the time difference after a chunk
# #round() can be used over difftime() or we can directly do it during print() later.
          res <- difftime(Sys.time(), now)
          if (res > 1) {
# #insert in the list using "<<-"
            k_all_chunk_times_lt[[options$label]] <<- res
          }
      }
    }
  }))
  knitr::opts_chunk$set(chunk_run_time = TRUE)
# #
# #Chunk Templates, use as: opts.label='twofig'
# #Overriden locally by: out.width = "33%" or "100%"
# #https://bookdown.org/yihui/rmarkdown-cookbook/opts-template.html
# #knitr::opts_template$set(twofig = list(), threefig = list())
  knitr::opts_template$set(twofig = list(
    fig.show = "hold", 
	fig.align = 'center', 
	out.width = "49%", 
	fig.asp = 0.8, 
	#fig.topcaption = TRUE, 
	fig.width = 7))
#
# #Max Resolution plots for ggsave()
  k_width <- 14
  k_height <- {9/16} * k_width
#
# #Save Definitions and Theorems for Glossary
  k_def_list = list()
  k_thm_list = list()
  k_cnj_list = list()
  k_exm_list = list()
  knitr::knit_hooks$set(engine = function(before, options) {
# #Set the hook once to handle All /both lists
    if ( before ) {
        if ( options$engine == "theorem" ) {
            k_thm_list[[options$label]] <<- options$name
        } else if ( options$engine == "definition" ) {
            k_def_list[[options$label]] <<- options$name
        } else if ( options$engine == "conjecture" ) {
            k_cnj_list[[options$label]] <<- options$name
        } else if ( options$engine == "example" ) {
            k_exm_list[[options$label]] <<- options$name
        }
    }
    NULL
  }) 
} else print("Knitr not loaded again.")

