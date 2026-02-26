let arr=[1,2,3,4,5,6,7,8,9,10]
let n=arr.length
let sums=0
for(let i=0;i<arr.length;i++){
   sums=sums+arr[i]
}
let avg=sums/n
let even=0
let odd=0
for(let i=0;i<n;i++){
    if(arr[i]%2==0){
        even=even+1
    }
    else{
        odd=odd+1
    }
}
console.log(`Total=${sums}`)
console.log(`Average=${avg}`)
console.log(`Total number of even numbers=${even}`)
console.log(`Total number of odd numbers=${odd}`)