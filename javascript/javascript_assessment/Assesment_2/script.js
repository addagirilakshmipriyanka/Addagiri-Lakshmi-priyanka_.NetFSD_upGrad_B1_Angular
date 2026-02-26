let counter = 0;
function updateDisplay() {
    document.getElementById("counterValue").textContent = counter;
}

function incrementCounter(step) {
    counter = counter + step;
    updateDisplay();
}
function resetCounter() {
    counter = 0;
    updateDisplay();
}

document.getElementById("incrementBtn").addEventListener("click", function () {
    incrementCounter(1);  
});
document.getElementById("resetBtn").addEventListener("click", resetCounter);