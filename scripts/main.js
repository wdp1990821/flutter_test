// let myHeading = document.querySelector('h1');
// myHeading.textContent = "Hello World!!!" + 10;

// 注释
let myVariable = "李雷";
myVariable = "Hello";

// let a = 9 / 3;
// let b = 8 * 2;

// let iceCream = 'chocolate';
// if (iceCream === 'chocolate') {
//     alert("喜欢巧克力");
// } else {
//     alert("不是巧克力吗？");
// }

// let myVv = document.querySelector("p");
// alert("hello");

// function multiply(num1, num2) {
//     let result = num1 + num2;
//     return result;
// }

// document.querySelector("html").onclick = function () {
// alert("别摸我");
// }

let myImage = document.querySelector('img');

myImage.onclick = function () {
    let mySrc = myImage.getAttribute('src');
    if (mySrc === 'images/background.jpg') {
        myImage.setAttribute('src', 'images/saber.png');
    } else {
        myImage.setAttribute("src", "images/background.jpg");
    }
}

let myButton = document.querySelector("button");
let myHeading = document.querySelector('h1');

function setUserName() {
    let myName = prompt('请输入你的名字。');
    if (!myName || myName === null) {
        setUserName();
    } else {
        localStorage.setItem('name', myName);
        myHeading.innerHTML = 'Mozilla 酷毙了，' + myName;
    }
}

if (!localStorage.getItem('name')) {
    setUserName();
} else {
    let storedName = localStorage.getItem('name');
    myHeading.textContent = 'Mozilla 酷毙了，' + storedName;
}

myButton.onclick = function () {
    setUserName();
}

