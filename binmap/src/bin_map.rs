#[allow(non_snake_case)]
use std::collections::HashMap;

use wasm_bindgen::prelude::{wasm_bindgen, JsValue};

#[wasm_bindgen]
#[derive(PartialEq, Debug)]
pub struct BinMap(HashMap<Box<[u8]>, JsValue>);

#[wasm_bindgen]
impl BinMap {
  #[wasm_bindgen(constructor)]
  pub fn new() -> Self {
    Self(HashMap::new())
  }

  pub fn clear(&mut self) {
    self.0.clear()
  }

  #[wasm_bindgen(getter)]
  pub fn size(&self) -> usize {
    self.0.len()
  }

  pub fn has(&mut self, key: &[u8]) -> bool {
    self.0.contains_key(key)
  }

  pub fn delete(&mut self, key: &[u8]) -> bool {
    self.0.remove(key).is_some()
  }

  pub fn set(&mut self, key: &[u8], val: JsValue) {
    if val == JsValue::UNDEFINED {
      self.delete(key);
    } else {
      self.0.insert(Box::from(key), val);
    }
  }

  pub fn get(&self, key: &[u8]) -> JsValue {
    match self.0.get(key) {
      Some(r) => r.clone(),
      None => JsValue::UNDEFINED,
    }
  }

  // pub fn dump(&self) -> Vec<u8> {
  //   self.write_to_vec().unwrap()
  // }

  // pub fn len(&self) -> usize {
  //   self.0.len()
  // }
  //
  // #[wasm_bindgen]
  // pub fn load(bin: &[u8]) -> BinMap {
  //   BinMap::read_from_buffer(bin).unwrap()
  // }
}
