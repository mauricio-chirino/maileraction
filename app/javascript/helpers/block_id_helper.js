// app/javascript/helpers/block_id_helper.js

export function uniqueBlockId(blockType) {
  if (crypto.randomUUID) {
    return `${blockType}-${crypto.randomUUID()}`;
  }
  // Fallback si randomUUID no existe
  return `${blockType}-${Date.now()}-${Math.floor(Math.random()*10000)}`;
}