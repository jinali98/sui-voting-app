import React from "react";
import ProposalView from "./views/proposal-view";
import Navbar from "./components/navbar";
import WalletView from "./views/wallet-view";
import { useNavigation } from "./providers/navigation/navigation-context";
const App: React.FC = () => {
  const theme ="dark"

  const Pages = () => {
    const { currentPage } = useNavigation();
  
    switch(currentPage) {
      case "/":
        return <ProposalView />
      case "/wallet":
        return <WalletView />
      default:
        return <div className="text-center">Page not found!</div>
    }
  };

  return (
    <div className={`${theme}`}>
      <div className="min-h-screen bg-gray-100 text-gray-900 dark:bg-gray-900 dark:text-gray-100">
        <Navbar />
        <div className="max-w-screen-xl m-auto pt-16">
          <h1 className="text-4xl font-bold mb-4">Simple Proposal App</h1>
          <Pages />
        </div>
      </div>
    </div>
  );
};

export default App;