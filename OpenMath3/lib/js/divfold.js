/* (un)folds an HTML <div/> element */
function omcd_divfold(_Id){
    var thisLevel = document.getElementById(_Id);
    var thisLevela = document.getElementById(_Id.concat("a"));
    if(thisLevel.style.display != "none"){ 
	thisLevel.style.display = "none";
	thisLevela.className = thisLevela.className.replace("omcd_active", "omcd_inactive");
    }else{
	thisLevel.style.display = "block";
	thisLevela.className = thisLevela.className.replace("omcd_inactive", "omcd_active");
    }  
}
