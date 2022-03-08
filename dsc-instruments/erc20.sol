contract Erc20 {
  struct OwnerTuple {
    address p;
    bool _valid;
  }
  struct TotalSupplyTuple {
    uint n;
    bool _valid;
  }
  struct AllowanceTuple {
    uint n;
    bool _valid;
  }
  struct UnequalBalanceTuple {
    uint s;
    uint n;
    bool _valid;
  }
  struct TotalBalancesTuple {
    uint m;
    bool _valid;
  }
  struct BalanceOfTuple {
    uint n;
    bool _valid;
  }
  UnequalBalanceTuple unequalBalance;
  TotalSupplyTuple totalSupply;
  TotalBalancesTuple totalBalances;
  mapping(address=>BalanceOfTuple) balanceOf;
  mapping(address=>mapping(address=>AllowanceTuple)) allowance;
  OwnerTuple owner;
  event TransferFrom(address from,address to,address spender,uint amount);
  event Burn(address p,uint amount);
  event Mint(address p,uint amount);
  event IncreaseAllowance(address p,address s,uint n);
  event Transfer(address from,address to,uint amount);
  constructor() public {
    updateOwnerOnInsertConstructor_r4();
  }
  function getTotalSupply() public view  returns (uint) {
      uint n = totalSupply.n;
      return n;
  }
  function approve(address p,address s,uint n) public  checkViolations  {
      bool r5 = updateIncreaseAllowanceOnInsertRecv_approve_r5(p,s,n);
      if(r5==false) {
        revert("Rule condition failed");
      }
  }
  function getBalanceOf(address p) public view  returns (uint) {
      BalanceOfTuple memory balanceOfTuple = balanceOf[p];
      uint n = balanceOfTuple.n;
      return n;
  }
  function transfer(address from,address to,uint amount) public  checkViolations  {
      bool r2 = updateTransferOnInsertRecv_transfer_r2(from,to,amount);
      if(r2==false) {
        revert("Rule condition failed");
      }
  }
  function mint(address p,uint amount) public  checkViolations  {
      bool r10 = updateMintOnInsertRecv_mint_r10(p,amount);
      if(r10==false) {
        revert("Rule condition failed");
      }
  }
  function getAllowance(address p,address s) public view  returns (uint) {
      AllowanceTuple memory allowanceTuple = allowance[p][s];
      uint n = allowanceTuple.n;
      return n;
  }
  function transferFrom(address from,address to,uint amount) public  checkViolations  {
      bool r14 = updateTransferOnInsertRecv_transferFrom_r14(from,to,amount);
      bool r18 = updateTransferFromOnInsertRecv_transferFrom_r18(from,to,amount);
      if(r14==false && r18==false) {
        revert("Rule condition failed");
      }
  }
  function burn(address p,uint amount) public  checkViolations  {
      bool r9 = updateBurnOnInsertRecv_burn_r9(p,amount);
      if(r9==false) {
        revert("Rule condition failed");
      }
  }
  function checkUnequalBalance() private    {
      UnequalBalanceTuple memory unequalBalanceTuple = unequalBalance;
      if(unequalBalanceTuple._valid==true) {
        revert("unequalBalance");
      }
  }
  modifier checkViolations() {
      // Empty()
      _;
      checkUnequalBalance();
  }
  function updateTotalOutOnInsertTransfer_r16(address p,uint n) private    {
      int delta = int(n);
      updateBalanceOfOnIncrementTotalOut_r1(p,delta);
  }
  function updateBalanceOfOnIncrementTotalMint_r1(address p,int n) private    {
      int delta = int(n);
      updateTotalBalancesOnIncrementBalanceOf_r17(delta);
      int _delta = int(n);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateUnequalBalanceOnIncrementTotalBalances_r15(int s) private    {
      int _delta = int(s);
      uint newValue = updateuintByint(totalBalances.m,_delta);
      updateUnequalBalanceOnInsertTotalBalances_r15(newValue);
  }
  function updateUnequalBalanceOnIncrementTotalSupply_r15(int n) private    {
      int _delta = int(n);
      uint newValue = updateuintByint(totalSupply.n,_delta);
      updateUnequalBalanceOnInsertTotalSupply_r15(newValue);
  }
  function updateTotalInOnInsertTransfer_r7(address p,uint n) private    {
      int delta = int(n);
      updateBalanceOfOnIncrementTotalIn_r1(p,delta);
  }
  function updateTotalMintOnInsertMint_r12(address p,uint n) private    {
      int delta = int(n);
      updateBalanceOfOnIncrementTotalMint_r1(p,delta);
  }
  function updateAllowanceOnIncrementSpentTotal_r6(address o,address s,int l) private    {
      int _delta = int(-l);
      uint newValue = updateuintByint(allowance[o][s].n,_delta);
      allowance[o][s].n = newValue;
  }
  function updateTransferOnInsertRecv_transfer_r2(address s,address r,uint n) private   returns (bool) {
      BalanceOfTuple memory balanceOfTuple = balanceOf[s];
      if(true) {
        uint m = balanceOfTuple.n;
        if(n<=m) {
          updateTotalOutOnInsertTransfer_r16(s,n);
          updateTotalInOnInsertTransfer_r7(r,n);
          emit Transfer(s,r,n);
          return true;
        }
      }
      return false;
  }
  function updateUnequalBalanceOnDeleteTotalSupply_r15(uint n) private    {
      if(true) {
        uint s = totalBalances.m;
        if(s!=n) {
          unequalBalance = UnequalBalanceTuple(0,0,false);
        }
      }
  }
  function updateOwnerOnInsertConstructor_r4() private    {
      if(true) {
        address s = msg.sender;
        if(true) {
          owner = OwnerTuple(s,true);
        }
      }
  }
  function updateMintOnInsertRecv_mint_r10(address p,uint n) private   returns (bool) {
      if(true) {
        address s = owner.p;
        if(s==msg.sender) {
          if(n>0) {
            updateAllMintOnInsertMint_r0(n);
            updateTotalMintOnInsertMint_r12(p,n);
            emit Mint(p,n);
            return true;
          }
        }
      }
      return false;
  }
  function updateBurnOnInsertRecv_burn_r9(address p,uint n) private   returns (bool) {
      if(true) {
        address s = owner.p;
        if(s==msg.sender) {
          BalanceOfTuple memory balanceOfTuple = balanceOf[p];
          if(true) {
            uint m = balanceOfTuple.n;
            if(n<=m) {
              updateTotalBurnOnInsertBurn_r11(p,n);
              updateAllBurnOnInsertBurn_r19(n);
              emit Burn(p,n);
              return true;
            }
          }
        }
      }
      return false;
  }
  function updateAllMintOnInsertMint_r0(uint n) private    {
      int delta = int(n);
      updateTotalSupplyOnIncrementAllMint_r13(delta);
  }
  function updateBalanceOfOnIncrementTotalIn_r1(address p,int i) private    {
      int delta = int(i);
      updateTotalBalancesOnIncrementBalanceOf_r17(delta);
      int _delta = int(i);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateUnequalBalanceOnDeleteTotalBalances_r15(uint s) private    {
      if(true) {
        uint n = totalSupply.n;
        if(s!=n) {
          unequalBalance = UnequalBalanceTuple(0,0,false);
        }
      }
  }
  function updateSpentTotalOnInsertTransferFrom_r3(address o,address s,uint n) private    {
      int delta = int(n);
      updateAllowanceOnIncrementSpentTotal_r6(o,s,delta);
  }
  function updateTotalBurnOnInsertBurn_r11(address p,uint n) private    {
      int delta = int(n);
      updateBalanceOfOnIncrementTotalBurn_r1(p,delta);
  }
  function updateAllowanceTotalOnInsertIncreaseAllowance_r8(address o,address s,uint n) private    {
      int delta = int(n);
      updateAllowanceOnIncrementAllowanceTotal_r6(o,s,delta);
  }
  function updateTotalSupplyOnIncrementAllMint_r13(int m) private    {
      int delta = int(m);
      updateUnequalBalanceOnIncrementTotalSupply_r15(delta);
      int _delta = int(m);
      uint newValue = updateuintByint(totalSupply.n,_delta);
      totalSupply.n = newValue;
  }
  function updateTotalBalancesOnIncrementBalanceOf_r17(int n) private    {
      int delta = int(n);
      updateUnequalBalanceOnIncrementTotalBalances_r15(delta);
      int _delta = int(n);
      uint newValue = updateuintByint(totalBalances.m,_delta);
      totalBalances.m = newValue;
  }
  function updateIncreaseAllowanceOnInsertRecv_approve_r5(address o,address s,uint n) private   returns (bool) {
      if(o==msg.sender) {
        AllowanceTuple memory allowanceTuple = allowance[o][s];
        if(true) {
          uint m = allowanceTuple.n;
          if(true) {
            uint d = n-m;
            updateAllowanceTotalOnInsertIncreaseAllowance_r8(o,s,d);
            emit IncreaseAllowance(o,s,d);
            return true;
          }
        }
      }
      return false;
  }
  function updateTotalSupplyOnIncrementAllBurn_r13(int b) private    {
      int delta = int(-b);
      updateUnequalBalanceOnIncrementTotalSupply_r15(delta);
      int _delta = int(-b);
      uint newValue = updateuintByint(totalSupply.n,_delta);
      totalSupply.n = newValue;
  }
  function updateuintByint(uint x,int delta) private   returns (uint) {
      int convertedX = int(x);
      int value = convertedX+delta;
      uint convertedValue = uint(value);
      return convertedValue;
  }
  function updateAllBurnOnInsertBurn_r19(uint n) private    {
      int delta = int(n);
      updateTotalSupplyOnIncrementAllBurn_r13(delta);
  }
  function updateUnequalBalanceOnInsertTotalBalances_r15(uint s) private    {
      TotalBalancesTuple memory toDelete = totalBalances;
      if(toDelete._valid==true) {
        updateUnequalBalanceOnDeleteTotalBalances_r15(toDelete.m);
      }
      if(true) {
        uint n = totalSupply.n;
        if(s!=n) {
          unequalBalance = UnequalBalanceTuple(s,n,true);
        }
      }
  }
  function updateTransferOnInsertRecv_transferFrom_r14(address o,address r,uint n) private   returns (bool) {
      if(true) {
        address s = msg.sender;
        AllowanceTuple memory allowanceTuple = allowance[o][s];
        if(true) {
          uint k = allowanceTuple.n;
          BalanceOfTuple memory balanceOfTuple = balanceOf[o];
          if(true) {
            uint m = balanceOfTuple.n;
            if(m>=n && k>=n) {
              updateTotalOutOnInsertTransfer_r16(o,n);
              updateTotalInOnInsertTransfer_r7(r,n);
              emit Transfer(o,r,n);
              return true;
            }
          }
        }
      }
      return false;
  }
  function updateBalanceOfOnIncrementTotalOut_r1(address p,int o) private    {
      int delta = int(-o);
      updateTotalBalancesOnIncrementBalanceOf_r17(delta);
      int _delta = int(-o);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
  function updateTransferFromOnInsertRecv_transferFrom_r18(address o,address r,uint n) private   returns (bool) {
      if(true) {
        address s = msg.sender;
        AllowanceTuple memory allowanceTuple = allowance[o][s];
        if(true) {
          uint k = allowanceTuple.n;
          BalanceOfTuple memory balanceOfTuple = balanceOf[o];
          if(true) {
            uint m = balanceOfTuple.n;
            if(m>=n && k>=n) {
              updateSpentTotalOnInsertTransferFrom_r3(o,s,n);
              emit TransferFrom(o,r,s,n);
              return true;
            }
          }
        }
      }
      return false;
  }
  function updateAllowanceOnIncrementAllowanceTotal_r6(address o,address s,int m) private    {
      int _delta = int(m);
      uint newValue = updateuintByint(allowance[o][s].n,_delta);
      allowance[o][s].n = newValue;
  }
  function updateUnequalBalanceOnInsertTotalSupply_r15(uint n) private    {
      TotalSupplyTuple memory toDelete = totalSupply;
      if(toDelete._valid==true) {
        updateUnequalBalanceOnDeleteTotalSupply_r15(toDelete.n);
      }
      if(true) {
        uint s = totalBalances.m;
        if(s!=n) {
          unequalBalance = UnequalBalanceTuple(s,n,true);
        }
      }
  }
  function updateBalanceOfOnIncrementTotalBurn_r1(address p,int m) private    {
      int delta = int(-m);
      updateTotalBalancesOnIncrementBalanceOf_r17(delta);
      int _delta = int(-m);
      uint newValue = updateuintByint(balanceOf[p].n,_delta);
      balanceOf[p].n = newValue;
  }
}