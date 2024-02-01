export interface ChatItemType {
  imagePath: ResourceStr | any;
  nickName: string;
  messageContent?: string;
  messageTime?: string;
  newMessageAmount?: number;
}

export interface MessageItemType {
  isNewSend?: boolean;
  state: string;
  icon: ResourceStr | any;
  message: string;
}