var Arr=new Array()
/* Do *not* use special characters like single quotes or double quotes or anything else that either
   Javascript *or* HTML do not like! */

Arr[0]='<br/>Get 2-35% Ca$hback for Your Everyday Online Purchases!';

Arr[1]='<br/>Great Ca$hback Program with 1/2% Referral Bonus for Each Friend - Forever!';

Arr[2]='<br/>Get Ca$hBack from THOUSANDS of Partner Stores including WalMart & Target!';

Arr[3]='<br/>Get 2-35% Ca$hBack While You Shop Online -- Great Deals!';

Arr[4]='<br/>Your One-Stop Online Shop with Great Ca$hback and 1000s of Partner Stores';

Arr[5]='<br/>Get 2-35% Ca$hBack for all your Personal and Small Business Needs';

document.write('<a href="http://juliesmarket.com" target="_blank"><b>Julie&#39;s Market</b></a>'
	+ Arr[Math.floor(Math.random()*Arr.length)]);
