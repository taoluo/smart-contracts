contract Wallet {
  struct BalanceOfTuple {
    int n;
    bool _valid;
  }
  struct TotalSupplyTuple {
    int n;
    bool _valid;
  }
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct NegativeBalanceKeyTuple {
    address p;
  }
  mapping(address=>BalanceOfTuple) balanceOf;
  TotalSupplyTuple totalSupply;
  OwnerTuple owner;
  NegativeBalanceKeyTuple[] negativeBalanceKeyArray;
  event Transfer(address from,address to,int amount);
  event Mint(address p,int amount);
  event Burn(address p,int amount);
  constructor() public {
    updateOwnerOnInsertConstructor_r5();
  }
  function getTotalSupply() public view  returns (int) {
      int n = totalSupply.n;
      return n;
  }
  function mint(address p,int amount) public    {
      bool r3 = updateMintOnInsertRecv_mint_r3(p,amount);
      if(r3==false) {
        revert("Rule condition failed");
      }
  }
  function burn(address p,int amount) public    {
      bool r12 = updateBurnOnInsertRecv_burn_r12(p,amount);
      if(r12==false) {
        revert("Rule condition failed");
      }
  }
  function transfer(address from,address to,int amount) public    {
      bool r4 = updateTransferOnInsertRecv_transfer_r4(from,to,amount);
      if(r4==false) {
        revert("Rule condition failed");
      }
  }
  function getBalanceOf(address p) public view  returns (int) {
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      int n = balanceOfTuple.n;
      return n;
  }
  function updateBalanceOfOnIncrementTotalOut_r2(address p,int o) private    {
      balanceOf[p].n -= o;
  }
  function updateAllBurnOnInsertBurn_r10(int n) private    {
      int delta = int(n);
      updateTotalSupplyOnIncrementAllBurn_r11(delta);
  }
  function updateBalanceOfOnIncrementTotalIn_r2(address p,int i) private    {
      balanceOf[p].n += i;
  }
  function updateTotalOutOnInsertTransfer_r6(address p,int n) private    {
      int delta = int(n);
      updateBalanceOfOnIncrementTotalOut_r2(p,delta);
  }
  function updateTotalSupplyOnIncrementAllBurn_r11(int b) private    {
      totalSupply.n -= b;
  }
  function updateMintOnInsertRecv_mint_r3(address p,int n) private   returns (bool) {
      if(true) {
        address s = owner.p;
        if(s==msg.sender) {
          if(n>0) {
            updateAllMintOnInsertMint_r0(n);
            updateTransferOnInsertMint_r9(p,n);
            emit Mint(p,n);
            return true;
          }
        }
      }
      return false;
  }
  function updateOwnerOnInsertConstructor_r5() private    {
      if(true) {
        address s = msg.sender;
        if(true) {
          owner = OwnerTuple(s,true);
        }
      }
  }
  function updateTransferOnInsertBurn_r7(address p,int n) private    {
      if(true) {
        updateTotalOutOnInsertTransfer_r6(p,n);
        updateTotalInOnInsertTransfer_r1(address(0),n);
        emit Transfer(p,address(0),n);
      }
  }
  function updateTotalSupplyOnIncrementAllMint_r11(int m) private    {
      totalSupply.n += m;
  }
  function updateintByint(int x,int delta) private   returns (int) {
      int newValue = x+delta;
      return newValue;
  }
  function updateTransferOnInsertRecv_transfer_r4(address s,address r,int n) private   returns (bool) {
      BalanceOfTuple memory balanceOfTuple = balanceOf[s];
      if(true) {
        int m = balanceOfTuple.n;
        if(m>=n) {
          updateTotalOutOnInsertTransfer_r6(s,n);
          updateTotalInOnInsertTransfer_r1(r,n);
          emit Transfer(s,r,n);
          return true;
        }
      }
      return false;
  }
  function updateBurnOnInsertRecv_burn_r12(address p,int n) private   returns (bool) {
      if(true) {
        address s = owner.p;
        if(s==msg.sender) {
          BalanceOfTuple memory balanceOfTuple = balanceOf[p];
          if(true) {
            int m = balanceOfTuple.n;
            if(n<=m) {
              updateTransferOnInsertBurn_r7(p,n);
              updateAllBurnOnInsertBurn_r10(n);
              emit Burn(p,n);
              return true;
            }
          }
        }
      }
      return false;
  }
  function updateTotalInOnInsertTransfer_r1(address p,int n) private    {
      int delta = int(n);
      updateBalanceOfOnIncrementTotalIn_r2(p,delta);
  }
  function updateAllMintOnInsertMint_r0(int n) private    {
      int delta = int(n);
      updateTotalSupplyOnIncrementAllMint_r11(delta);
  }
  function updateTransferOnInsertMint_r9(address p,int n) private    {
      if(true) {
        updateTotalOutOnInsertTransfer_r6(address(0),n);
        updateTotalInOnInsertTransfer_r1(p,n);
        emit Transfer(address(0),p,n);
      }
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
}