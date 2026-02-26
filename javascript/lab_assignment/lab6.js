let arr=[10,20,30,40,50,60]
let n=arr.length;
let total=0
for(let i=0;i<n;i++){
    total=total+arr[i]
}
let Average=total/n
if(Average>=90){
    grade="A"
}
else if(Average>=75){
     grade="B"
}
else if(Average>=60){
    grade="C"
}
else{
    grade="Fail"
}
console.log(`total=${total}`)
console.log(`Average=${Average}`)
console.log(`Grade=${grade}`)
