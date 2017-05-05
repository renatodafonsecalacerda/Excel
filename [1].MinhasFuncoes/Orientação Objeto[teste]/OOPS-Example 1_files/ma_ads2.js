var Arr=new Array()
/* Do *not* use special characters like single quotes or double quotes or anything else that either
   Javascript *or* HTML do not like! */

Arr[0]='<br/>Take control of your E-Commerce web site! See a FREE demo.';

Arr[1]='<br/>Stop paying for every update!  Ask for a FREE demo.';

Arr[2]='<br/>Enhance your Web Presence! Get your customized FREE demo.';

Arr[3]='<br/>Enable your web site for E-Commerce!  Get a FREE demo.';

Arr[4]='<br/>Is your web site easy to maintain? Ask for a FREE demo.';

Arr[5]='<br/>Let Us Impress You with a FREE Web Site Demo!';

document.write('<a href="http://w.mawebcenters.com/TotalWebSolution/build.html" target="_blank">'
	+ '<b>Total Web Solution</b></a>'
	+ Arr[Math.floor(Math.random()*Arr.length)])
