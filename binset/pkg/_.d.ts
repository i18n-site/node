/* tslint:disable */
/* eslint-disable */
/**
*/
export class BinSet {
  free(): void;
/**
*/
  constructor();
/**
* @param {Uint8Array} key
*/
  add(key: Uint8Array): void;
/**
* @param {Uint8Array} key
* @returns {boolean}
*/
  has(key: Uint8Array): boolean;
/**
* @returns {Uint8Array}
*/
  dump(): Uint8Array;
/**
* @param {Uint8Array} bin
* @returns {BinSet}
*/
  static load(bin: Uint8Array): BinSet;
/**
*/
  readonly size: number;
}
