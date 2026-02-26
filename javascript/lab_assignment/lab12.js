let start=1
let end=50
let count=0
for(let num=start;num<=end;num++){
     if(num<2){
        continue
     }
     let isPrime=true
     for(let i=2;i<=Math.sqrt(num);i++){
        if(num%i==0){
            isPrime=false
            break
        }
     }
  if(isPrime){
    console.log(num)
    count++;
  }
}
console.log(`total prime numbers=${count}`)
