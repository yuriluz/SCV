var mySidenav = document.getElementById("mySidenav");

function w3_open() {
	if (mySidenav.style.display === 'block') {
		mySidenav.style.display = 'none';
	} else {
		mySidenav.style.display = 'block';
	}
}

function w3_close() {
	mySidenav.style.display = "none";
}
