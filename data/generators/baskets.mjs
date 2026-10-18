import {readFileSync} from 'node:fs';
export const model = JSON.parse(readFileSync(new URL('../models/basket-boundaries.json',import.meta.url)));
export function* baskets() {
 for(let a=0;a<model.breakfastPricesPaise.length;a++) for(let b=0;b<model.beveragePricesPaise.length;b++)
 for(const qa of model.quantities) for(const qb of model.quantities) for(const addOn of model.breakfastAddOnPaise) {
  const lines=[{sku:`fixture-breakfast-${a}`,unitPricePaise:model.breakfastPricesPaise[a],quantity:qa,addOnPaise:addOn},
   {sku:`fixture-beverage-${b}`,unitPricePaise:model.beveragePricesPaise[b],quantity:qb,addOnPaise:0}];
  const subtotal=lines.reduce((s,l)=>s+(l.unitPricePaise+l.addOnPaise)*l.quantity,0);
  const cap=Math.floor(subtotal/5);
  for(const boundary of model.rewardBalances) {
   const balance=boundary==='zero'?0:boundary==='cap-minus-one'?cap-1:boundary==='cap'?cap:cap+1;
   for(const fulfilment of model.fulfilment) for(const useRewards of model.useRewards) {
    const fee=fulfilment==='delivery' && subtotal<=9900?2000:0;
    const used=useRewards?Math.min(balance,cap):0;
    const id=`BM-BASKET-a${a}-b${b}-qa${qa}-qb${qb}-x${addOn}-${boundary}-${fulfilment}-${useRewards?'on':'off'}`;
    yield {id,requirements:['BM-CAT','BM-PRICE','BM-WALLET'],scope:'isolated-basket-pricing',classification:'boundary-combination',
     input:{lines,availableRewardPaise:balance,fulfilment,useRewards},
     expected:{subtotalPaise:subtotal,deliveryFeePaise:fee,rewardUsedPaise:used,totalPaise:subtotal+fee-used},
     policies:['tax-free-coupon-free-controlled-fixture','floor-to-paise-PROPOSED'],status:'generated-not-executed'};
   }
  }
 }
}
