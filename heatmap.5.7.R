##  2. Ritu 03/28/06 If ColSideColors==NULL, one doesn''t have to specify phenotype color labels
##  3. Ritu 04/14/06 If RowSideColors==NULL, one doesn''t have to specify chr color bar
##  4. Ritu 04/14/06 Can use 1 col matrix too
##  5. Ritu 04/14/06 If totalC!=nc, image will be w.r.t totalC instead of using whole window
##  6. Ritu 07/19/06 Can use 1 row phenotype color labels
##  7. Ritu 08/24/06 adjust margins
##  8. Ritu 07/05/07 Make amplifications smaller
##  9. Ritu 03/18/08 If totalC!=nc, colulmn color bars will be w.r.t totalC instead of using whole window
##				Not perfect for column dendrogram
## 10. Ritu 04/28/08 RowSideColors==NULL option which was not working before is now fixed
## 11. Ritu 08/30/09 New option RowSideColors as a matrix
## 12. Ritu 01/14/10 New option cexAmp
## 13. Ritu 02/08/11 Returns the cluster objects
## 14. Ritu 03/31/11 Returns cluster objects only if they exist
## 15. Ritu 02/17/12 Draw lines on heatmap
## 16. Ritu 03/27/13 Delineate clusters. Specify params ncr, ncc. Rowv, Colv have to be hclust objects if ncr, ncc are specified
## 17. Ritu 12/05/13 New param font for label
## 18. Ritu 12/05/13 Row cluster delineation was not working - too many delineations. Needed modified function rect.hclust.my
## 19. Ritu 01/22/16 New option addText
## 20. Ritu 02/17/16 Can specify exact colors to use for heatmap. Use param high. If length of high > 1 then mid & mid will be ignored
## 21. Ritu 05/17/16 Default linkage method set to ward.D
## 22. Ritu 05/30/16 New option lineColor
## 23. Ritu 08/28/16 Modified addText to display word instead of character. New option cexText
## 24. Ritu 01/27/18 New options lwidRowSide - row side width, lheiColSide - column side height, cexRowSide - row side font size, cexColSide - column side font size, densColor - to shade row/column side missing values

## 24. Ritu
heatmap3 <- function (x, imp = TRUE, Rowv = NA, Colv = NULL, distfun = dist,
hclustfun = hclust, add.expr, symm = FALSE, revC = identical(Colv, "Rowv"),
scale = "none", na.rm = TRUE, margins = c(5,5), ColSideColors, RowSideColors,
cexRow = 0.2 + 1/log10(nr), cexCol = 0.2 + 1/log10(nc), fontRow=1, fontCol=1, labRow = NULL, labCol = NULL, lineRow = NULL, lineCol = NULL, lineColor="black",
totalC=nc, ncr=NA, ncc=NA, main = NULL, xlab = NULL, ylab = NULL, verbose = getOption("verbose"),
methodR = "ward.D", methodC = "ward.D", zlm = c(-0.5, 0.5), high="green", low="red", mid="black",
addamps=NULL, colamps=NULL, cexAmp=.25, addText=NULL, cexText=1, lwidRowSide=0.2, lheiColSide=0.2, cexRowSide=1,cexColSide=1, densColor=NULL, ...)
### 23. Ritu
#heatmap3 <- function (x, imp = TRUE, Rowv = NA, Colv = NULL, distfun = dist,hclustfun = hclust, add.expr, symm = FALSE, revC = identical(Colv, "Rowv"),scale = "none", na.rm = TRUE, margins = c(5,5), ColSideColors, RowSideColors,cexRow = 0.2 + 1/log10(nr), cexCol = 0.2 + 1/log10(nc), fontRow=1, fontCol=1, labRow = NULL, labCol = NULL, lineRow = NULL, lineCol = NULL, lineColor="black",totalC=nc, ncr=NA, ncc=NA, main = NULL, xlab = NULL, ylab = NULL, verbose = getOption("verbose"),methodR = "ward.D", methodC = "ward.D", zlm = c(-0.5, 0.5), high="green", low="red", mid="black",addamps=NULL, colamps=NULL, cexAmp=.25, addText=NULL, cexText=1, ...)
#### 22. Ritu
##heatmap3 <- function (x, imp = TRUE, Rowv = NA, Colv = NULL, distfun = dist,hclustfun = hclust, add.expr, symm = FALSE, revC = identical(Colv, "Rowv"),scale = "none", na.rm = TRUE, margins = c(5,5), ColSideColors, RowSideColors,cexRow = 0.2 + 1/log10(nr), cexCol = 0.2 + 1/log10(nc), fontRow=1, fontCol=1, labRow = NULL, labCol = NULL, lineRow = NULL, lineCol = NULL, lineColor="black",totalC=nc, ncr=NA, ncc=NA, main = NULL, xlab = NULL, ylab = NULL, verbose = getOption("verbose"),methodR = "ward.D", methodC = "ward.D", zlm = c(-0.5, 0.5), high="green", low="red", mid="black",addamps=NULL, colamps=NULL, cexAmp=.25, addText=NULL, ...)
##### 21. Ritu
###heatmap3 <- function (x, imp = TRUE, Rowv = NA, Colv = NULL, distfun = dist, hclustfun = hclust, add.expr, symm = FALSE, revC = identical(Colv, "Rowv"),scale = "none", na.rm = TRUE, margins = c(5,5), ColSideColors, RowSideColors,cexRow = 0.2 + 1/log10(nr), cexCol = 0.2 + 1/log10(nc), fontRow=1, fontCol=1, labRow = NULL, labCol = NULL, lineRow = NULL, lineCol = NULL,totalC=nc, ncr=NA, ncc=NA, main = NULL, xlab = NULL, ylab = NULL, verbose = getOption("verbose"),methodR = "ward.D", methodC = "ward.D", zlm = c(-0.5, 0.5), high="green", low="red", mid="black",addamps=NULL, colamps=NULL, cexAmp=.25, addText=NULL, ...)
##### 19. Ritu
####heatmap3 <- function (x, imp = TRUE, Rowv = NA, Colv = NULL, distfun = dist,hclustfun = hclust, add.expr, symm = FALSE, revC = identical(Colv, "Rowv"),scale = "none", na.rm = TRUE, margins = c(5,5), ColSideColors, RowSideColors,cexRow = 0.2 + 1/log10(nr), cexCol = 0.2 + 1/log10(nc), fontRow=1, fontCol=1, labRow = NULL, labCol = NULL, lineRow = NULL, lineCol = NULL,totalC=nc, ncr=NA, ncc=NA, main = NULL, xlab = NULL, ylab = NULL, verbose = getOption("verbose"),methodR = "ward", methodC = "ward", zlm = c(-0.5, 0.5), high="green", low="red", mid="black",addamps=NULL, colamps=NULL, cexAmp=.25, addText=NULL, ...)
###### 17. Ritu
####heatmap3 <- function (x, imp = TRUE, Rowv = NA, Colv = NULL, distfun = dist,hclustfun = hclust, add.expr, symm = FALSE, revC = identical(Colv, "Rowv"),scale = "none", na.rm = TRUE, margins = c(5,5), ColSideColors, RowSideColors,cexRow = 0.2 + 1/log10(nr), cexCol = 0.2 + 1/log10(nc), fontRow=1, fontCol=1, labRow = NULL, labCol = NULL, lineRow = NULL, lineCol = NULL,totalC=nc, ncr=NA, ncc=NA, main = NULL, xlab = NULL, ylab = NULL, verbose = getOption("verbose"),methodR = "ward", methodC = "ward", zlm = c(-0.5, 0.5), high="green", low="red", mid="black",addamps=NULL, colamps=NULL, cexAmp=.25, ...)
####### 16. Ritu
#####heatmap3 <- function (x, imp = TRUE, Rowv = NA, Colv = NULL, distfun = dist, hclustfun = hclust, add.expr, symm = FALSE, revC = identical(Colv, "Rowv"), scale = "none", na.rm = TRUE, margins = c(5,5), ColSideColors, RowSideColors, cexRow = 0.2 + 1/log10(nr), cexCol = 0.2 + 1/log10(nc), labRow = NULL, labCol = NULL, lineRow = NULL, lineCol = NULL,totalC=nc, ncr=NA, ncc=NA, main = NULL, xlab = NULL, ylab = NULL, verbose = getOption("verbose"), methodR = "ward", methodC = "ward", zlm = c(-0.5, 0.5), high="green", low="red", mid="black",addamps=NULL, colamps=NULL, cexAmp=.25, ...)
######heatmap3 <- function (x, imp = TRUE, Rowv = NA, Colv = NULL, distfun = dist, hclustfun = hclust, add.expr, symm = FALSE, revC = identical(Colv, "Rowv"), scale = "none", na.rm = TRUE, margins = c(5,5), ColSideColors, RowSideColors, cexRow = 0.2 + 1/log10(nr), cexCol = 0.2 + 1/log10(nc), labRow = NULL, labCol = NULL, lineRow = NULL, lineCol = NULL,totalC=nc, main = NULL, xlab = NULL, ylab = NULL, verbose = getOption("verbose"), methodR = "ward", methodC = "ward", zlm = c(-0.5, 0.5), high="green", low="red", mid="black",addamps=NULL, colamps=NULL, cexAmp=.25, ...)
{
	## 4. Ritu
	if (!is.matrix(x)) {f
		x <- matrix(x,ncol=1)
		if (!is.null(addamps)) {
			addamps <- matrix(addamps,ncol=1)
		}
        ## 19. Ritu
        if (!is.null(addText)) {
            addText <- matrix(addText,ncol=1)
        }
	}
    scale <- if (symm && missing(scale))
	"none"
    else match.arg(scale)
    if (length(di <- dim(x)) != 2 || !is.numeric(x)) stop("`x' must be a numeric matrix")
    nr <- di[1]
    nc <- di[2]
	## 4. Ritu
    #if (nr <= 1 || nc <= 1) stop("`x' must have at least 2 rows and 2 columns")
    if (nr <= 1 || nc < 1) stop("`x' must have at least 2 rows and 1 column")
    if (!is.numeric(margins) || length(margins) != 2) stop("`margins' must be a numeric vector of length 2")
    doRdend <- !identical(Rowv, NA)
    doCdend <- !identical(Colv, NA)
    if (is.null(Rowv)) Rowv <- rowMeans(x, na.rm = na.rm)
    if (is.null(Colv)) Colv <- colMeans(x, na.rm = na.rm)
    if (doRdend) {
        if (inherits(Rowv, "hclust")) {
			## 16. Ritu
            hcr <- Rowv
            ddr <- as.dendrogram(hcr)
        } else if (inherits(Rowv, "dendrogram")) 
            ddr <- Rowv
        else {
            hcr <- hclustfun(distfun(x), method = methodR)
            ddr <- as.dendrogram(hcr)
            if (!is.logical(Rowv) || Rowv) 
                ddr <- reorder(ddr, Rowv)
        }
        if (nr != length(rowInd <- order.dendrogram(ddr))) stop("row dendrogram ordering gave index of wrong length")
    } else rowInd <- 1:nr
    if (doCdend) {
        if (inherits(Colv, "hclust")) {
			## 16. Ritu
            hcc <- Colv
            ddc <- as.dendrogram(hcc)
        } else if (inherits(Colv, "dendrogram")) 
            ddc <- Colv
        else if (identical(Colv, "Rowv")) {
            if (nr != nc) stop("Colv = \"Rowv\" but nrow(x) != ncol(x)")
            ddc <- ddr
        }
        else {
            hcc <- hclustfun(distfun(if (symm) x else t(x)), method = methodC)
            ddc <- as.dendrogram(hcc)
            if (!is.logical(Colv) || Colv) ddc <- reorder(ddc, Colv)
        }
        if (nc != length(colInd <- order.dendrogram(ddc))) stop("column dendrogram ordering gave index of wrong\nlength")
    } else colInd <- 1:nc
    x <- x[rowInd, colInd]
    if (is.null(labRow)) labRow <- if (is.null(rownames(x))) (1:nr)[rowInd] else rownames(x)
    if (is.null(labCol)) labCol <- if (is.null(colnames(x))) (1:nc)[colInd] else colnames(x)
    if (scale == "row") {
        x <- sweep(x, 1, rowMeans(x, na.rm = na.rm))
        sx <- apply(x, 1, sd, na.rm = na.rm)
        x <- sweep(x, 1, sx, "/")
    } else if (scale == "column") {
        x <- sweep(x, 2, colMeans(x, na.rm = na.rm))
        sx <- apply(x, 2, sd, na.rm = na.rm)
        x <- sweep(x, 2, sx, "/")
    }
    lmat <- rbind(c(NA, 3), 2:1)
    #lwid <- c(if (doRdend) 1 else 0.05, 4)
    #lhei <- c((if (doCdend) 1 else 0.05) + if (!is.null(main)) 0.2 else 0, 4)

	## 7. Ritu
	#lwid <- c(1, 4)
	#lhei <- c(1 + if (!is.null(main)) 0.2 else 0, 4)
	lwid <- c(ifelse(doRdend,1,0.01), 4)
	lhei <- c(ifelse(doCdend,1,0.01) + ifelse(is.null(main),0,0.2), 4)

	## 2. Ritu
	if (!is.null(ColSideColors)) {
        #if (!missing(ColSideColors)) {
           # if (!is.character(ColSideColors) || length(ColSideColors) != 
            #    nc) 
              #  stop("'ColSideColors' must be a character vector of\nlength ncol(x)")

            ## 6. Ritu
            if (!is.matrix(ColSideColors)) {
                ColSideColors <- matrix(ColSideColors,nrow=1)
                rownames(ColSideColors) <- ""
            }

        ## 11. Ritu
        #lmat <- rbind(lmat[1, ] + 1, c(NA, 1), lmat[2, ] + 1)
        lmat <- rbind(lmat[1, ] + 1, c(rep(NA, ncol(lmat) - 1),1), lmat[2, ] + 1)

        ## 24. Ritu
        lhei <- c(lhei[1], 0.2, lhei[2])
    }
	## 3. Ritu
    if (!is.null(RowSideColors)) {
        #if (!missing(RowSideColors)) {
            #if (!is.character(RowSideColors) || length(RowSideColors) != nr) 
            #    stop("'RowSideColors' must be a character vector of\nlength nrow(x)")
            #lmat <- cbind(lmat[, 1] + 1, c(rep(NA, nrow(lmat) - 1), 1), lmat[, 2] + 1)
            #lwid <- c(lwid[1], 0.2, lwid[2])

        ## 11. Ritu
        if (!is.matrix(RowSideColors)) {
            RowSideColors <- matrix(RowSideColors,nrow=1)
            rownames(RowSideColors) <- ""
        }
        lmat <- cbind(lmat[, 1] + 1, c(rep(NA, nrow(lmat) - 1), 1), lmat[, 2] + 1)
        ## 24. Ritu
        #lwid <- c(lwid[1], 0.2, lwid[2])
        lwid <- c(lwid[1], lwidRowSide, lwid[2])
    }
    lmat[is.na(lmat)] <- 0
    if (verbose) {
        cat("layout: widths = ", lwid, ", heights = ", lhei, "; lmat=\n")
        print(lmat)
    }

################################
#redo lmat:

	## 1. Ritu
	#if (!is.matrix(ColSideColors)) {
		#ColSideColors <- matrix(ColSideColors,nrow=1,dimnames=list(names(ColSideColors),1:nc))
	#}

	## 2. Ritu
    if (!is.null(ColSideColors)) {
        nr.my=nrow(ColSideColors)+2

        ## 11. Ritu
        #nc.my=3
        #nfig=nr.my+2
        #lmat=matrix(0, nrow=nr.my, ncol=nc.my)
        #lmat[nr.my,]=c(nfig-1,1,nfig-2)
        #lmat[1, nc.my]=nfig
        #lmat[2:(nr.my-1),nc.my]=(nfig-3):2
        nc.my=2+ifelse(is.null(RowSideColors),0,nrow(RowSideColors))
        nfig=nr.my+nc.my-1
        lmat=matrix(0, nrow=nr.my, ncol=nc.my)
        if (is.null(RowSideColors)) {
            lmat[nr.my,]=c(nfig-1,nfig-2)
        } else {
            lmat[nr.my,]=c(nfig-1,1:nrow(RowSideColors),nfig-2)
            ## 24. Ritu
            #lwid <- c(ifelse(doRdend,1,0.01), rep(.2, nrow(RowSideColors)), 4)
            lwid <- c(ifelse(doRdend,1,0.01), rep(lwidRowSide, nrow(RowSideColors)), 4)
        }
        lmat[1, nc.my]=nfig
        lmat[2:(nr.my-1),nc.my]=(nfig-3):(nc.my-1)

        ## 11. Ritu
        ### 10. Ritu
        #if (is.null(RowSideColors)) {
        #	lmat=lmat[,c(1,3:ncol(lmat))]
        #	lmat=lmat-1
        #	lmat[lmat==(-1)]=0
        #}

        ## 24. Ritu
        ### 7. Ritu
        ##lhei=c(1, rep(.2, nrow(ColSideColors)),4)
        #lhei <- c(ifelse(doCdend,1,0.01) + ifelse(is.null(main),0,0.2), rep(.2, nrow(ColSideColors)), 4)
        lhei <- c(ifelse(doCdend,1,0.01) + ifelse(is.null(main),0,0.2), rep(lheiColSide, nrow(ColSideColors)), 4)
    }

	notRequired=function(x) {
        ## 11. Ritu
        if (!is.null(RowSideColors)) {
            nr.my=nrow(RowSideColors)+2
            nc.my=nrow(ColSideColors)+2
            nfig=nr.my+2
            lmat=matrix(0, nrow=nr.my, ncol=nc.my)
            lmat[nr.my,]=c(nfig-1,1,nfig-2)
            lmat[1, nc.my]=nfig
            lmat[2:(nr.my-1),nc.my]=(nfig-3):2
            if (is.null(ColSideColors)) {
                lmat=lmat[,c(1,3:ncol(lmat))]
                lmat=lmat-1
                lmat[lmat==(-1)]=0
            }
            lhei <- c(ifelse(doCdend,1,0.01) + ifelse(is.null(main),0,0.2), rep(.2, nrow(RowSideColors)), 4)
        }
	}

###################################
    op <- par(no.readonly = TRUE)
    on.exit(par(op))
    if (verbose) {
        cat("Final layout: widths = ", lwid, ", heights = ", lhei, "; lmat=\n")
        print(lmat)
    }

    #layout(lmat, widths = lwid, heights = lhei, respect = TRUE)
    layoutThis=layout(lmat, widths = lwid, heights = lhei, respect = TRUE)
    #layout.show(layoutThis)
    #layout.show(n=nfig)

	## 3. Ritu
	if (!is.null(RowSideColors)) {
    #if (!missing(RowSideColors)) {
		par(mar = c(margins[1], 0, 0, 0.5))

		## 11. Ritu
		#if (revC) {
		#	image(rbind(1:nr), col = RowSideColors[rev(rowInd)], axes = FALSE)
		#} else {
        #	image(rbind(1:nr), col = RowSideColors[rowInd], axes = FALSE)
		#}
		if (revC) {
			j=rev(rowInd)
		} else {
			j=rowInd
		}
		for (i in 1:nrow(RowSideColors)) {
            image(rbind(1:nr), col = RowSideColors[i,j], axes = FALSE)
            #image(rbind(1:nr), z=rbind(1:nr),col = RowSideColors[i,j], axes = FALSE)
            #image(cbind(1:nr), z=cbind(1:nr),col = RowSideColors[i,j], axes = FALSE)
            ## 24. Ritu
            if (!is.null(densColor)) {
                if (any(is.na(RowSideColors[i,j]))) {
                    for (jj in which(is.na(RowSideColors[i,j]))) {
                        rect(-1,jj-0.5,1,jj+0.5,density=densColor)
                    }
                }
            }
            ## 24. Ritu
            #mtext(side=1, text=as.character(rownames(RowSideColors)[i]), las=3, cex=1)
            mtext(side=1, text=as.character(rownames(RowSideColors)[i]), las=3, cex=cexRowSide)
        }
	}
	## 2. Ritu
    if (!is.null(ColSideColors)) {
        #if (!missing(ColSideColors)) {
        par(mar = c(0.5, 0, 0, margins[2]))
        for (i in 1:nrow(ColSideColors)) {
            ## 9. Ritu
            #image(cbind(1:nc), col = ColSideColors[i,colInd], axes = FALSE)
            image(cbind(1:nc), z=cbind(1:nc),col = ColSideColors[i,colInd], axes = FALSE, xlim = 0.5 + c(0, totalC))
            ## 24. Ritu
            if (!is.null(densColor)) {
                if (any(is.na(ColSideColors[i,colInd]))) {
                    for (jj in which(is.na(ColSideColors[i,colInd]))) {
                        rect(jj-0.5,-1,jj+0.5,1,density=densColor)
                    }
                }
            }
            ## 24. Ritu
            #mtext(side=2, text=as.character(rownames(ColSideColors)[i]), las=1, cex=1)
            mtext(side=2, text=as.character(rownames(ColSideColors)[i]), las=1, cex=cexColSide)
        }
    }
    par(mar = c(margins[1], 0, 0, margins[2]))
    if (!symm || scale != "none") 
        x <- t(x)
    if (revC) {
        iy <- nr:1
        ddr <- rev(ddr)
        x <- x[, iy]
    }
    else iy <- 1:nr
    x.floor <- x
    for (i in 1:ncol(x)) {
        ind1 <- (1:length(x[, i]))[x[, i] >= zlm[2] & !is.na(x[,i])]
        ind2 <- (1:length(x[, i]))[x[, i] <= zlm[1] & !is.na(x[,i])]
        x.floor[, i][ind1] <- rep((zlm[2] - 0.01), length(ind1))
        x.floor[, i][ind2] <- rep((zlm[1] + 0.01), length(ind2))
    }
	## 5. Ritu
    #image(1:nc, 1:nr, x.floor, xlim = 0.5 + c(0, nc), ylim = 0.5 + c(0, nr), axes = FALSE, xlab = "", ylab = "", col = maPalette(high = high, low = low, mid = mid), zlim = zlm, ...)
    if (length(high)>1) {
        ## 20. Ritu
        colThis=high
    } else {
        colThis=maPalette(high = high, low = low, mid = mid)
    }
	if (nc==1) {
        ## 20. Ritu
        #image(1:(2*nc), 1:nr, rbind(x.floor,x.floor), xlim = 0.5 + c(0, 2*totalC), ylim = 0.5 + c(0, nr), axes = FALSE, xlab = "", ylab = "", col = maPalette(high = high, low = low, mid = mid), zlim = zlm, ...)
	    image(1:(2*nc), 1:nr, rbind(x.floor,x.floor), xlim = 0.5 + c(0, 2*totalC), ylim = 0.5 + c(0, nr), axes = FALSE, xlab = "", ylab = "", col = colThis, zlim = zlm, ...)
	} else {
        ## 20. Ritu
        #image(1:nc, 1:nr, x.floor, xlim = 0.5 + c(0, totalC), ylim = 0.5 + c(0, nr), axes = FALSE, xlab = "", ylab = "", col = maPalette(high = high, low = low, mid = mid), zlim = zlm, ...)
        image(1:nc, 1:nr, x.floor, xlim = 0.5 + c(0, totalC), ylim = 0.5 + c(0, nr), axes = FALSE, xlab = "", ylab = "", col = colThis, zlim = zlm, ...)
	}
	## 15. Ritu
	if (!is.null(lineCol)) {
        ## 22. Ritu
        #abline(v=lineCol)
        abline(v=lineCol,col=lineColor)
	}
	## 15. Ritu
	if (!is.null(lineRow)) {
        ## 22. Ritu
        #abline(h=lineRow)
        abline(h=lineRow,col=lineColor)
	}
    
##################

## 19. Ritu
if (!is.null(addText)) {
    addText=addText[rowInd, colInd]
    if (!is.matrix(addText)) {
        addText <- matrix(addText,ncol=1)
    }
    for (i in 1:ncol(addText)) {
        j=which(!is.na(addText[,i]))
        ## 23. Ritu
        #points(rep(i, length(j)), j, pch=addText[j,i])
        if (length(j)!=0) text(i, j, labels=addText[j,i], cex=cexText)
    }
}

if (!is.null(addamps)) {
    addamps=addamps[rowInd, colInd]
    ## 4. Ritu
    if (!is.matrix(addamps)) {
        addamps <- matrix(addamps,ncol=1)
    }
    for (i in 1:ncol(addamps)) {
        amp=which(addamps[,i]>0)
        ## 12. Ritu
        ### 8. Ritu
        ##points(rep(i, length(amp)), amp, col=colamps, cex=.75, pch=20)
        #points(rep(i, length(amp)), amp, col=colamps, cex=.25, pch=20)
        points(rep(i, length(amp)), amp, col=colamps, cex=cexAmp, pch=20)
    }
 }
    
################

	## 17. Ritu
	#axis(1, 1:nc, labels = labCol[colInd], las = 2, line = -0.5, tick = 0, cex.axis = cexCol)
    axis(1, 1:nc, labels = labCol[colInd], las = 2, line = -0.5, tick = 0, cex.axis = cexCol, font.axis=fontCol)
    if (!is.null(xlab)) 
        mtext(xlab, side = 1, line = margins[1] - 1.25)
	## 17. Ritu
	#axis(4, iy, labels = labRow[rowInd], las = 2, line = -0.5, tick = 0, cex.axis = cexRow)
    axis(4, iy, labels = labRow[rowInd], las = 2, line = -0.5, tick = 0, cex.axis = cexRow, font.axis=fontRow)
    if (!is.null(ylab)) 
        mtext(ylab, side = 4, line = margins[2] - 1.25)
    if (!missing(add.expr)) 
        eval(substitute(add.expr))
    par(mar = c(margins[1], 0, 0, 0))
    if (doRdend) {
        plot(ddr, horiz = TRUE, axes = FALSE, yaxs = "i", leaflab = "none")
		## 16. Ritu
		if (exists("hcr") & !is.na(ncr)) {
			## 18. Ritu
			#if (class(hcc)=="hclust") rect.hclust(hcr,k=ncr) else stop("Must be of class hclust to delineate clusters")
			if (class(hcr)=="hclust") rect.hclust.my(hcr,k=ncr,horiz=TRUE) else stop("Must be of class hclust to delineate clusters")
			print(ncr)
		}		
    } else frame()
	## 9. Ritu
	if (totalC==nc) {
		par(mar = c(0, 0, if (!is.null(main)) 1 else 0, margins[2]))
	} else {
		par(mar = c(0, 0, if (!is.null(main)) 1 else 0, 2*(totalC-nc)+1+margins[2]))
	}
	if (doCdend) {
		plot(ddc, axes = FALSE, xaxs = "i", leaflab = "none")
		## 16. Ritu
		if (exists("hcc") & !is.na(ncc)) {
			## 18. Ritu
			#if (class(hcc)=="hclust") rect.hclust(hcc,k=ncc) else stop("Must be of class hclust to delineate clusters")
			if (class(hcc)=="hclust") rect.hclust.my(hcc,k=ncc) else stop("Must be of class hclust to delineate clusters")
		}
	} else if (!is.null(main)) {
        frame()
	}
    if (!is.null(main)) 
        title(main, cex.main = 1.5 * op[["cex.main"]])
	
	## 13. Ritu
	#invisible(list(rowInd = rowInd, colInd = colInd))
	out=list(rowInd = rowInd, colInd = colInd, rowClust=NULL, colClust=NULL)

	## 14. Ritu
	#if (doRdend) out$rowClust=hcr
	#if (doCdend) out$colClust=hcc
    if (exists("hcr")) out$rowClust=hcr
    if (exists("hcc")) out$colClust=hcc

    invisible(out)
}

rect.hclust.my=function (tree, k = NULL, which = NULL, x = NULL, h = NULL, border = 2, cluster = NULL, horiz = FALSE) {
    if (length(h) > 1L | length(k) > 1L) stop("'k' and 'h' must be a scalar")
    if (!is.null(h)) {
        if (!is.null(k)) 
		stop("specify exactly one of 'k' and 'h'")
        k <- min(which(rev(tree$height) < h))
        k <- max(k, 2)
    } else if (is.null(k)) {
		stop("specify exactly one of 'k' and 'h'")
	}
    if (k < 2 | k > length(tree$height)) 
	stop(gettextf("k must be between 2 and %d", length(tree$height)), domain = NA)
    if (is.null(cluster)) 
	cluster <- cutree(tree, k = k)
    clustab <- table(cluster)[unique(cluster[tree$order])]
    m <- c(0, cumsum(clustab))
    if (!is.null(x)) {
        if (!is.null(which)) 
		stop("specify exactly one of 'which' and 'x'")
        which <- x
        for (n in seq_along(x)) which[n] <- max(which(m < x[n]))
    }
    else if (is.null(which)) 
	which <- 1L:k
    if (any(which > k)) 
	stop(gettextf("all elements of 'which' must be between 1 and %d", k), domain = NA)
    border <- rep_len(border, length(which))
    retval <- list()
    for (n in seq_along(which)) {
		if (horiz) {
			## 18. Ritu
			rect(mean(rev(tree$height)[(k - 1):k]), m[which[n]] + 0.66, par("usr")[2L], m[which[n] + 1] + 0.33, border = border[n])
		} else {
			rect(m[which[n]] + 0.66, par("usr")[3L], m[which[n] + 1] + 0.33, mean(rev(tree$height)[(k - 1):k]), border = border[n])
		}
#		rect(xleft, ybottom, xright, ytop, density = NULL, angle = 45,col = NA, border = NULL, lty = par("lty"), lwd = par("lwd"),
        retval[[n]] <- which(cluster == as.integer(names(clustab)[which[n]]))
    }
    invisible(retval)
}

######################################################################
######################################################################
######################################################################


script <- function() {
library(RColorBrewer)
library(marray)
library(sma)
library(aCGH)

#row colors (chromosomes)

chrominfo=human.chrom.info.Jul03
clinfo <- clones.info(tumor.acgh)
chromcols <- rep(NA, nrow(clinfo))

for (i in 1:23)
{
	if (is.odd(i))
	{
		#chromcols[which(clinfo$Chrom==i & clinfo$kb >= chrominfo$centromere[i])] <- "yellowgreen"
		#chromcols[which(clinfo$Chrom==i & clinfo$kb < chrominfo$centromere[i])] <- "green"
		chromcols[which(clinfo$Chrom==i)] <- "gray10"
		
	}
	else if (!(is.odd(i)))
	{
		#chromcols[which(clinfo$Chrom==i & clinfo$kb >= chrominfo$centromere[i])] <- "skyblue"
		#chromcols[which(clinfo$Chrom==i & clinfo$kb < chrominfo$centromere[i])] <- "blue"
		chromcols[which(clinfo$Chrom==i)] <- "gray90"
		
	}
}

sampnm1 <- sample.names(tumor.acgh)[ind.match.tumor]

ind.samp <- which(!is.na(ind.match.tumor))
ind.cl=which(clinfo$Chrom<=23 & clinfo$Clone!="RMC01P009")

#create color bars accoridng to clinical variables

sampCols=matrix(NA, nrow=7, ncol=nrow(phenData))

#expression subtype

rsp=as.numeric(phenData$subCor)
tmp=brewer.pal(length(unique(rsp[!is.na(rsp)])),"Accent")

sampcols <- rep(NA, length(rsp))
for (i in 1:length(tmp))
{
	sampcols[which(rsp==i)]=tmp[i]
}
sampcols[which(sampcols=="#FFFF99")]="yellow2"
sampCols[1,]=sampcols

#pr
rsp=rep(NA, nrow(phenData))
rsp[which(phenData$pr=="pos")]=1
rsp[which(phenData$pr=="neg")]=0
sampcols[which(rsp==1)]="blue"
sampcols[which(rsp==0)]="skyblue"

sampCols[2,]=sampcols

#er
rsp=rep(NA, nrow(phenData))
rsp[which(phenData$er=="pos")]=1
rsp[which(phenData$er=="neg")]=0
sampcols[which(rsp==1)]="blue"
sampcols[which(rsp==0)]="skyblue"

sampCols[3,]=sampcols

#p53
rsp=rep(NA, nrow(phenData))
rsp[which(phenData$p53==0)]=1
rsp[which(phenData$p53==1)]=2

sampcols <- rep(NA, length(rsp))
sampcols[which(rsp==1)]="skyblue"
sampcols[which(rsp==2)]="blue"

sampCols[4,]=sampcols

#ki67

rsp=I(phenData$ki67>10)
rsp[which(rsp==TRUE)]=2
rsp[which(rsp==FALSE)]=1

sampcols <- rep(NA, length(rsp))
sampcols[which(rsp==1)]="skyblue"
sampcols[which(rsp==2)]="blue"

sampCols[5,]=sampcols

#size

rsp=rep(NA, nrow(phenData))
rsp[which(phenData$size<=median(phenData$size, na.rm=T))]=1
rsp[which(phenData$size>median(phenData$size, na.rm=T))]=2

sampcols <- rep(NA, length(rsp))
sampcols[which(rsp==1)]="skyblue"
sampcols[which(rsp==2)]="blue"

sampCols[6,]=sampcols

#nodal.status

rsp=rep(NA, nrow(phenData))
rsp[which(phenData$nodal.status==0)]=1
rsp[which(phenData$nodal.status==1)]=2

sampcols <- rep(NA, length(rsp))
sampcols[which(rsp==1)]="skyblue"
sampcols[which(rsp==2)]="blue"

sampCols[7,]=sampcols

########################

rownames(sampCols)=c("Expression subtype", "PR status", "ER status", "p53 status", "ki67 status", "size", "nodal status")

#########################

#main data (smoothed with outliers)
tmp <- tumor.smoothed.impute.aber$aber.val[ind.cl,][rev(1:nrow(clinfo[ind.cl,])),ind.match.tumor]

#amplifications to be added as yellow dots
tmpamp <- tumor.amplif[ind.cl,][rev(1:nrow(clinfo[ind.cl,])),ind.match.tumor]

postscript("try.ps", paper="letter")
try10=heatmap3(x=tmp[,ind.samp], Rowv=NA, Colv=NULL, distfun = dist.cor.func, hclustfun = hclust,  symm=F, ColSideColors = sampCols[,ind.samp], RowSideColors=chromcols[ind.cl][rev(1:length(chromcols[ind.cl]))], labCol=as.character(sampnm1)[ind.samp], labRow=NA, scale="none", na.rm = F, margins = c(5, 5), main = NULL, xlab = NULL, ylab = NULL, zlm=c(-.5,.5), addamps=tmpamp[,ind.samp], colamps="yellow")
dev.off()
}
