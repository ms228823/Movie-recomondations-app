import React from 'react'
// import { useState } from 'react'
import '../../assets/css/AccountAndSettings/AccountAndSettings.css'
// import '../../'

function AccountAndSettings() {
    return (
        <div className="settings-container">
          <div className="settings-header">
            <p>Account & Settings</p>
          </div>
    
          <div className="settings-list">
            <ul>
              <li><a href="#" className="settings-set">Your account</a></li>
              <li><a href="#">Language</a></li>
              <li><a href="#">Devices</a></li>
            </ul>
          </div>
    
          <hr />
          <div className="settings-content">
            <div className="settings-wc1 txt-blk">
              <div className="settings-wc1-1 txt-blk">
                <h4>Your details</h4>
              </div>
              <div className="settings-wc1-2 settings-btn">
                <p className='bold-lighter'>Change your Name, Email, Mobile Number, Password, and more.</p>
                <button>
                  <a href="https://www.amazon.com/ap/cnep/ref=atv_set_ya_cha_acc_det?...">
                    <i className="fa-solid fa-arrow-up-right-from-square">
                      <span>Edit on Amazon</span>
                    </i>
                  </a>
                </button>
              </div>
            </div>
      
            <hr />
      
            <div className="settings-wc2 txt-blk">
              <div className="settings-wc2-1">
                <h4>Prime membership</h4>
              </div>
              <br />
              <div className="settings-wc2-2 settings-btn">
                <p className='bold-lighter'>
                  Please go to the Amazon website to view details or make changes to your Prime membership.
                </p>
                <button>
                  <a href="https://amazon.eg/gp/primecentral/ref=atv_set_ya_mem_edt_on_amz">
                    <i className="fa-solid fa-arrow-up-right-from-square">
                      <span>Manage or Cancel</span>
                    </i>
                  </a>
                </button>
              </div>
      
              <br />
      
              <div className="settings-wc2-21">
                <p>Payment method</p>
                <br />
              </div>
      
              <div className="settings-wc2-2-2 settings-btn">
                <p className='bold-lighter'>
                  Changing this payment method also updates your payment method for Prime membership and add-on
                  subscriptions on Prime videos.
                </p>
                <button>
                  <a href="https://amazon.eg/gp/primecentral/ref=atv_set_ya_mem_edt_on_amz">
                    <i className="fa-solid fa-arrow-up-right-from-square">
                      <span>Manage Payment method</span>
                    </i>
                  </a>
                </button>
              </div>
            </div>
          </div>

        </div>
      );
}

export default AccountAndSettings
