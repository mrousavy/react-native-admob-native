import { NativeModules } from 'react-native';

type AdmobNativeType = {
  multiply(a: number, b: number): Promise<number>;
};

const { AdmobNative } = NativeModules;

export default AdmobNative as AdmobNativeType;
