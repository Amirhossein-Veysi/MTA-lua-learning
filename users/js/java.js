const $ = document;
const loginButton = $.querySelector("#login-btn");
const signupButton = $.querySelector("#signup-btn");
const login = $.querySelector(".login-form");
const signup = $.querySelector(".signup-form");
const showSignup = $.querySelector("#show-signup");
const showLogin = $.querySelector("#show-login");

showSignup.addEventListener("click", () => {
  login.classList.add("d-none");
  signup.classList.remove("d-none");
});

showLogin.addEventListener("click", () => {
  signup.classList.add("d-none");
  login.classList.remove("d-none");
});

signupButton.addEventListener("click", test);
loginButton.addEventListener("click", tes);

function tes() {
  let username = document.getElementById("username").value;
  let password = document.getElementById("password").value;
  mta.triggerEvent("ssj", username, password);
}

function test() {
  let email = document.getElementById("signup-email").value;
  let username = document.getElementById("signup-username").value;
  let password = document.getElementById("signup-password").value;
  mta.triggerEvent("cmsg", email, username, password);
}

function teso(cod) {
  mta.triggerEvent("cm", cod);
}

// song system

var songs = [
  "https://j.top4top.io/m_1887sfjnz1.mp3",
  "https://l.top4top.io/m_1887dhljf1.mp3",
  "https://a.top4top.io/m_188723m4g1.mp3",
];

var song = new Audio();
var currentSong = 0; // it point to the current song

window.onload = playSong; // it will call the function playSong when window is load

function playSong() {
  song.src = songs[currentSong]; //set the source of 0th song
  song.play(); // play the song
}

function playOrPauseSong() {
  if (song.paused) {
    song.play();
  } else {
    song.pause();
  }
}

song.addEventListener("timeupdate", function () {
  if (song.currentTime == song.duration) {
    next();
  }
});

function next() {
  currentSong++;
  if (currentSong > songs.length - 1) {
    currentSong = 0;
  }
  playSong();
}

//
