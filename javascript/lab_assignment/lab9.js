let arr=[10,30,20,45,34,67,56]
let largest=arr[0]
let small=arr[0]
for(let i=0;i<arr.length;i++){
    if(arr[i]>largest){
        largest=arr[i]
    }
    else if(arr[i]<small){
        small=arr[i]
    }
}
console.log(`largest element in an array:${largest}`)
console.log(`smallest element in an array:${small}`)