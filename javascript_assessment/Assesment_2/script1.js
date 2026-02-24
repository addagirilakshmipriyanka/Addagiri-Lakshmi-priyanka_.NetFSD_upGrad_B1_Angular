let student = {
    name: "Priya",
    rollNo: 101,
    marks: 75
};
function updateStudentProfile(studentObj) {
    let profileDiv = document.getElementById("profileBox");
    profileDiv.innerHTML =
        "<p><strong>Name:</strong> " + studentObj.name + "</p>" +
        "<p><strong>Roll No:</strong> " + studentObj.rollNo + "</p>" +
        "<p><strong>Marks:</strong> " + studentObj.marks + "</p>";
}
function updateMarks(newMarks) {
    student.marks = newMarks;
    updateStudentProfile(student);
}
document.getElementById("updateBtn").addEventListener("click", function () {
    let newMarksValue = document.getElementById("marksInput").value;
    updateMarks(newMarksValue);
});
updateStudentProfile(student);