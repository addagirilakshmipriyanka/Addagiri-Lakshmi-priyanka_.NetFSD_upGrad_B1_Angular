let sal=[1000,2000,3000,4000,5000]
let n=sal.length
let totalsal=0
for(let i=0;i<sal.length;i++){
   totalsal=totalsal+sal[i]
}
let avg=totalsal/n
console.log(`totalsalary=${totalsal}`)
console.log(`average=${avg}`)
for(let i=0;i<n;i++){
    if(sal[i]>avg){
            console.log(`Employee ${i+1}=${sal[i]}`)

    }
}
