import { SuiObjectResponse, Coin } from "@mysten/sui/client"
import { FC } from "react";

type SuiObjectProps = {
  objectRes: SuiObjectResponse
};

export const SuiObject: FC<SuiObjectProps> = ({ objectRes }) => {

  const owner = objectRes.data?.owner;
  const type = objectRes.data?.type;
  const isCoin = type?.includes("0x2::coin::Coin");
  const balance = isCoin ? (objectRes.data?.content as Coin).fields?.balance : -1;

  return (
    <div
      key={objectRes.data?.objectId}
      className="p-2 border rounded-lg bg-gray-50 dark:bg-gray-800"
    >
      <p className="text-gray-700 dark:text-gray-300">
        <strong>ID:</strong> {objectRes.data?.objectId}
      </p>
      <p className="text-gray-700 dark:text-gray-300">
        <strong>Type:</strong> {type}
      </p>
      <p className="text-gray-700 dark:text-gray-300">
        <strong>Owner:</strong> {
          typeof owner === "object" && owner !== null && "AddressOwner" in owner
            ? owner.AddressOwner
            : "Unknow"
        }
      </p>
      { isCoin && (
        <p className="text-gray-700 dark:text-gray-300">
          <strong>Balance:</strong> {balance}
        </p>
      )}
    </div>
  )
};