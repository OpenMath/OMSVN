/* function reformulateLinks() {
// ------------------------
	s = document.location.toString();
	n = incrementPageNumber ( 1, s );
	for ( i=0; i< document.links.length; i++) {
		document.links[i].href = n;
		}
	}*/

function gotoNext() {
// ----------------
	//alert("we are at " + document.location.href.toString());
	document.location.href = ( 
		incrementPageNumber ( 1, document.location.href.toString() ) );
	return false;
	}
	

function gotoPrevious() {
// ----------------
	//alert("we are at " + document.location.href.toString());
	document.location.href = ( 
		incrementPageNumber ( -1, document.location.href.toString() ) );
	return false;
	}

function incrementPageNumber (step, str) {
// -------------------------
	
        // find last seperator
        a = str.lastIndexOf("/");
	// find the positions of the number
	p =-1; q=-1;
	for ( i=a; i< str.length; i++) {
		isNumber = false;
		t  = str.toString().charAt(i);
		if ( t == "0" || t=="1" || t=="2" || t=="3" || t=="4" || t=="5" || t=="6" || t=="7" || t=="8" || t=="9") isNumber = true;
		if ( p == -1 && isNumber ) p = i;
		if ( p != -1 && q == -1 && ! isNumber ) q = i;
		}
	 //alert("i=" + i + " t=" + t +" p=" + p + " and q=" + q);

	// convert the number substring to an int
	num=0.0;
	for (i=p; i < q; i++) {
		num = num * 10.0;
		num = num + ( str.charAt(i)*1.0);
		//alert ( "num =" + num);
		}
	// add it to one
	num = num +step;
	// and make it a string
	if ( num < 10 ) num = "0" + "" + num;

	// return the replaced string
	n = str.substring(0, p) + (num) + str.substring(q,str.length);
	//alert(n);
	return n;
	}
    

// embed keyboard handling    
if (document.getElementsByTagName && (!document.all)){
     document.addEventListener('keydown',keydownhandler,true);
 }

function keydownhandler(myEvent)
{
    if (myEvent.which==37 || myEvent.which==39)
      {
	  if (myEvent.which==37) { 
	      // action for left arrow
         gotoPrevious();
	  }
	  if (myEvent.which==39) {
	     // action for right arrow
         gotoNext();
	  }
      }
}

