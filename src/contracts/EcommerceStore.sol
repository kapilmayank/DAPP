pragma solidity ^0.4.0;
contract EcommerceStore{
    enum ProductStatus {Open,Sold,Unsold}
    enum ProductCondition {New,Used}
    uint public productIndex;
    mapping(address=>mapping(uint=>Product)) stores;
    mapping(uint => address) productIdInStore;
    struct Bid{
    address bidder;
    uint productId;
    uint value;
    bool revealed;
    }
    struct Product{
    uint id;
    string name;
    string category;
    string imageLink;
    string descLink;
    uint auctionStartTime;
    uint auctionEndTime;
    uint startPrice;
    address highestBidder;
    uint highestBid;
    uint secondHighestBid;
    uint totalBids;
    ProductStatus status;
    ProductCondition condition;
    mapping(address => mapping(bytes32 => Bid)) bids;
    }
    function EcommerceStore () public{
    productIndex = 0;
    }

    function addProductTostore(string  _name,string  _category,string  _imageLink,string  _descLink,uint _auctionStartTime,uint _auctionEndTime,uint _startPrice,uint _productCondition) public {
    require(_auctionStartTime<_auctionEndTime);
    productIndex+=1;
    Product memory product =Product(productIndex,_name,_category,_imageLink,_descLink,_auctionStartTime,_auctionEndTime,_startPrice,0,0,0,0,ProductStatus.Open,ProductCondition(_productCondition));
    stores[msg.sender][productIndex]=product;
    productIdInStore[productIndex]=msg.sender;
    }
    function getProduct(uint _productId)  public view returns(uint,string ,string ,string ,string , uint,uint,uint,ProductStatus,ProductCondition){
    Product memory product=stores[productIdInStore[_productId]][_productId];
    return(product.id,product.name,product.category,product.imageLink,product.descLink,product.auctionStartTime,product.auctionEndTime,product.startPrice,product.status,product.condition);

    }
    function bid(uint _productId,bytes32 _bid) payable public returns(bool){
        Product storage product =stores[productIdInStore[_productId]][_productId];
        require(now>product.auctionStartTime);
        require(now<product.auctionEndTime);
        require(msg.value>product.startPrice);         
        require(product.bids[msg.sender][_bid].bidder==0);
        product.bids[msg.sender][_bid]=Bid(msg.sender,_productId,msg.value,false);
        product.totalBids +=1;
        return true;
    }
    function revealBid(uint _productId,string   _amount,string  _secret) public {
        Product storage product =stores[productIdInStore[_productId]][_productId];
        require(now>product.auctionEndTime);//revealing should be done only after the end of the auction 
        bytes32 sealedBid = sha3(_amount,_secret);
        Bid memory bidinfo = product.bids[msg.sender][sealedBid];
        require(bidinfo.bidder>0);
        require(bidinfo.revealed == false);
        uint refund;
        uint amount = stringToUint(_amount);
        if (bidinfo.value<amount){
            //They did'nt send enough amount, they lost
            refund=bidinfo.value;
        }
        else{
            //if first to reveal set as highest bidder
            if (product.highestBidder== 0){
                product.highestBidder = msg.sender;
                product.highestBid = amount;
                product.secondHighestBid = product.startPrice;
                refund = bidinfo.value-amount;
            }
            else{
                if (amount>product.highestBid){
                    product.secondHighestBid = product.highestBid;
                    product.highestBidder.transfer(product.highestBid);
                    product.highestBidder = msg.sender;
                    product.highestBid = amount;
                    refund = amount;

                }else{
                    refund = amount;
                }
            }
        }
        product.bids[msg.sender][sealedBid].revealed=true;
        if(refund>0){
            (msg.sender).transfer(refund);
        }
    }
    function highestBidderInfo(uint _productId)  public view  returns(address,uint,uint){
        Product memory product = stores[productIdInStore[_productId]][_productId];
        return (product.highestBidder,product.highestBid,product.secondHighestBid);

    }
    function totalBids(uint _productId)   public view returns(uint){
        Product memory product = stores[productIdInStore[_productId]][_productId];
        return product.totalBids;

    }
    function stringToUint(string  s)  private  pure returns (uint){
        bytes memory b = bytes(s);
        uint result = 0;
        for (uint i =0;i<b.length;i++){
            if(b[i]>=48 && b[i]<=57){
                result=result*10+uint(b[i])-48;
            }

        }
         return result;
    }


}
