import { SiContentful, SiPrimevideo } from "react-icons/si";
import "../../assets/css/Footer/Footer.css";
import { FaFileExcel } from "react-icons/fa";

export default function Footer() {
  //   const [hidden, setHidden] = useState(true);
  //   const [userHidden, setUserHidden] = useState(true);
  //   const [menuHidden, setMenuHidden] = useState(true);

  return (
    <div className="footerContainer">
      <div className="footerLogo">
        <SiPrimevideo className="footerLogoImg" />
        {/* <img src="../src/assets/prime.svg" alt="Prime Video Logo" className="footerLogoImg" /> */}
      </div>

      <div className="footerLstContainer">
        <ul className="footerLst">
          <li className="footerLstItem">
            <a href="/" className="footerLstLink">
              Terms and Privacy Notice
            </a>
          </li>
          <li className="footerLstItem">
            <a href="/" className="footerLstLink">
              Send us feedback
            </a>
          </li>
          <li className="footerLstItem">
            <a href="/" className="footerLstLink">
              Help
            </a>
          </li>
          <li className="footerLstItem">
            <address className="footerLstAdd">
              © 2025, amazon prime clone project, or its affiliates
            </address>
          </li>
        </ul>
      </div>
    </div>
  );
}
