#' Market descriptions
#'
#' A dataset containing Avvo markets. Can be used for easy lookup of marketid, marketkey, other descriptors within R.
#'
#' @description
#' \describe{
#'\item{marketkey}{Not widely used anymore, but may lurk in some old queries and reports. SEM campaigns still use marketkey in their names.}
#'
#'\item{marketid}{The definitive, unique id for markets.}
#'\item{region}{Name of the region.}
#'\item{state}{Full state name.}
#'\item{county}{Name of the county, without the word "County".}
#'\item{pa}{Practice Area, aka specialty.}
#'\item{block}{Binary indicating whether market is block or exclusive.}
#'\item{conversiondate}{Date the market was covnerted to block.}
#'
#' }
#' @section SQL Code:
#' \preformatted{
#' select b.ad_mkt_key as marketkey
#' ,a.ad_market_id marketid
#' ,a.ad_region_id regionid
#' ,a.specialty_id paid
#' ,a.ad_market_region_name region
#' ,a.ad_market_state_name state
#' ,a.ad_market_county_name county
#' ,a.ad_market_specialty_name pa
#' ,a.ad_market_active_flag active
#' ,a.ad_market_block_flag block
#' from dm.ad_market_dimension a
#' join dm.ad_mkt_dim b on b.ad_mkt_id=a.ad_market_id
#' }
#' @format A data.table with 465474 rows and 8 variables
#' @source dm.ad_market_dimension, dm.ad_mkt_dim.

"avvomarkets"
#> [1] "avvomarkets"


#' PPC multipliers for Avvo markets
#'
#' A dataset containing ppc values for each market
#'
#' @description
#'
#' @format A data.table with 470098 rows and 2 variables
#' @source dm.lz_ad_pricing_ppc. (Switch to dm.ad_pricing_ppc)
"ppc"
#> [1] "ppc"
