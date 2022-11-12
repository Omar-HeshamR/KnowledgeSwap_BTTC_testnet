/* SPDX-License-Identifier: MIT

-----------------------------
 Knowledge Smart Token Contract   
 #The most usefull token
 #The best crypto project 
---------------------------- 
 __  __                               ___              __                      ____                                      ______        __                        
/\ \/\ \                             /\_ \            /\ \                    /\  _`\                                   /\__  _\      /\ \                       
\ \ \/'/'    ___     ___   __  __  __\//\ \      __   \_\ \     __      __    \ \,\L\_\  __  __  __     __     _____    \/_/\ \/   ___\ \ \/'\      __    ___    
 \ \ , <   /' _ `\  / __`\/\ \/\ \/\ \ \ \ \   /'__`\ /'_` \  /'_ `\  /'__`\   \/_\__ \ /\ \/\ \/\ \  /'__`\  /\ '__`\     \ \ \  / __`\ \ , <    /'__`\/' _ `\  
  \ \ \\`\ /\ \/\ \/\ \L\ \ \ \_/ \_/ \ \_\ \_/\  __//\ \L\ \/\ \L\ \/\  __/     /\ \L\ \ \ \_/ \_/ \/\ \L\.\_\ \ \L\ \     \ \ \/\ \L\ \ \ \\`\ /\  __//\ \/\ \ 
   \ \_\ \_\ \_\ \_\ \____/\ \___x___/' /\____\ \____\ \___,_\ \____ \ \____\    \ `\____\ \___x___/'\ \__/.\_\\ \ ,__/      \ \_\ \____/\ \_\ \_\ \____\ \_\ \_\
    \/_/\/_/\/_/\/_/\/___/  \/__//__/   \/____/\/____/\/__,_ /\/___L\ \/____/     \/_____/\/__//__/   \/__/\/_/ \ \ \/        \/_/\/___/  \/_/\/_/\/____/\/_/\/_/
                                                                /\____/                                          \ \_\                                           
                                                                \_/__/                                            \/_/  
 ---------------------------- 

 */ pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";


contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    function name() public view virtual override returns (string memory) {
        return _name;
    }
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }
    function decimals() public view virtual override returns (uint8) {
        return 0;
    }
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
        }
        _balances[to] += amount;

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
        }
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
}

contract KStoken is ERC20 {
    
    address public Owner;
    mapping(address => uint) public staked;
    mapping(uint256 => uint256) public holdings;
    mapping(address => uint) private stakedFromTS;

    constructor() ERC20("Knowledge Swap Token T1", "KS-TOKEN T1") {
        Owner = msg.sender;
    }

    // disabled some of the final internal and safe functionalties to make judging smoother
    // functions are very simple, and will be signficintly enhanced and made more secure.
    // for example the hold function will take an NFT token rather than questionID, 1 of 38 enhacments to come

    function mint(address to, uint amount) external {
        // require(msg.sender == Owner, 'only Owner');
        _mint(to, amount * 1000000000000000000);
    }

    // 1000000000000000000
    function burn(uint amount) external {
        _burn(msg.sender, amount);
    }

    function bountyLeftOnQuestion(uint256 _questionID) public view returns(uint256){
        return holdings[_questionID];
    }

    //  still need to add requiring msg.sender to be question asker
    function holdBounty(uint256 _questionID, uint256 bountyAmount) external{
        bountyAmount = bountyAmount * 1000000000000000000;
        require(balanceOf(msg.sender) >= bountyAmount, "balance is <= bountyAmount");
        _transfer(msg.sender, address(this), bountyAmount);
        holdings[_questionID] = bountyAmount;
    }

    function awardBounty(uint256 _questionID, address _userToBeRewarded) external{
        _transfer(address(this), _userToBeRewarded, holdings[_questionID]);
        holdings[_questionID] = 0;
    }


    // STAKING FUNCTIONALTIES - NEEDS FINIALIZATION AND PROPPER POLISHING

    function stake(uint amount) external {
        require(amount > 0, "amount is <= 0");
        require(balanceOf(msg.sender) >= amount, "balance is <= amount");
        _transfer(msg.sender, address(this), amount);
        if (staked[msg.sender] > 0) {
            claim();
        }
        stakedFromTS[msg.sender] = block.timestamp;
        staked[msg.sender] += amount;
    }

    function unstake(uint amount) external {
        require(amount > 0, "amount is <= 0");
        require(staked[msg.sender] >= amount, "amount is > staked");
        claim();
        staked[msg.sender] -= amount;
        _transfer(address(this), msg.sender, amount);
    }

    function claim() public {
        require(staked[msg.sender] > 0, "staked is <= 0");
        uint secondsStaked = block.timestamp - stakedFromTS[msg.sender];
        uint rewards = staked[msg.sender] * secondsStaked / 3.154e7;
        _mint(msg.sender,rewards);
        stakedFromTS[msg.sender] = block.timestamp;
    }
}