#pragma once
#ifndef INV_FHE79_SCALAR_PARAMS_H
#define INV_FHE79_SCALAR_PARAMS_H

#include "fields/storage.cuh"
#include "fields/field.cuh"

namespace inv_fhe79 {
  struct fp_config {
    static constexpr unsigned limbs_count = 4;
    static constexpr unsigned omegas_count = 13;
    static constexpr unsigned modulus_bit_count = 79;
    // Max number of corrections in Barrett reductions. TODO: check what is the minimum.
    static constexpr unsigned num_of_reductions = 4;

    static constexpr storage<limbs_count> modulus = {0xb16ce001, 0x32de29d2, 0x6904};
    static constexpr storage<limbs_count> modulus_2 = {0x62d9c002, 0x65bc53a5, 0xd208};
    static constexpr storage<limbs_count> modulus_4 = {0xc5b38004, 0xcb78a74a, 0x1a410};
    // TODO: check format of negative modulus, and whether 3 or 4 limbs.
    // 3 limbs variant.
    //static constexpr storage<limbs_count> neg_modulus = {0x4e931fff, 0xcd21d62d, 0xffff96fb};
    // 4 limbs variant.
    static constexpr storage<limbs_count> neg_modulus = {0x4e931fff, 0xcd21d62d, 0xffff96fb, 0xffffffff};
    
    static constexpr storage<2 * limbs_count> modulus_wide = {0xb16ce001, 0x32de29d2, 0x6904, 0, 0, 0};
    static constexpr storage<2 * limbs_count> modulus_squared = {0x26d9c001, 0x57138fb3, 0xb8b73c99, 0xdf5bad43, 0x2b1471cb, 0};
    static constexpr storage<2 * limbs_count> modulus_squared_2 = {0x4db38002, 0xae271f66, 0x716e7932, 0xbeb75a87, 0x5628e397, 0};
    static constexpr storage<2 * limbs_count> modulus_squared_4 = {0x9b670004, 0x5c4e3ecc, 0xe2dcf265, 0x7d6eb50e, 0xac51c72f, 0};

    // For Barrett reduction. TODO.
    // Presumably this formula: https://github.com/ingonyama-zk/modular_multiplication/blob/b6872e611961ef3a3e42f8903b0834a9c0b6f99c/domb_barrett_mp.py#L65
    // Include the 4th limb value 1?
    // 3 limbs variant.
    //static constexpr storage<limbs_count> m = {0x939c5f20, 0x89718436, 0x3807070b};
    // 4 limbs variant.
    static constexpr storage<limbs_count> m = {0x20696029, 0x939c5f20, 0x89718436, 0x3807070b};

    static constexpr storage<limbs_count> one = {0x00000001, 0x00000000, 0x00000000};
    static constexpr storage<limbs_count> zero = {0x00000000, 0x00000000, 0x00000000};
    static constexpr storage<limbs_count> montgomery_r = {0xea094ff2, 0xb1e82600, 0x5c7};
    static constexpr storage<limbs_count> montgomery_r_inv = {0x5597866, 0xd75430ce, 0x4828};

    static constexpr storage_array<omegas_count, limbs_count> omega = {{
      {0xb16ce000, 0x32de29d2, 0x6904},
      {0xa1e0f647, 0xcf416696, 0x4dac},
      {0x7b84afd6, 0xa244c32d, 0x1a2f},
      {0xf7e9cde6, 0xaad48e42, 0x7f9},
      {0x3714f26f, 0x1eac9a2a, 0x102d},
      {0xca49ed0, 0xbd723704, 0x2e22},
      {0xa9926781, 0x29b849b0, 0x4a3},
      {0x18383499, 0x2c8aa970, 0x3706},
      {0x613ab563, 0xcbb3088d, 0x51e0},
      {0x77647d30, 0x24019adf, 0x63c},
      {0xb57c916a, 0x17cf2caf, 0x58ac},
      {0xf4db57d4, 0x313d025d, 0x1802},
      {0xfeccd1bd, 0x1e8f9cc3, 0x6186}
    }};

    static constexpr storage_array<omegas_count, limbs_count> omega_inv = {{
      {0xb16ce000, 0x32de29d2, 0x6904},
      {0xf8be9ba, 0x639cc33c, 0x1b57},
      {0x6b179285, 0x7a395f52, 0x3e9d},
      {0xcc2331, 0x64bee73b, 0x3471},
      {0xbd3fec10, 0xc922878, 0x3e31},
      {0x7e923ca4, 0x54d2cdd3, 0x185b},
      {0xbdae76a8, 0xfd92d33a, 0x3c28},
      {0x1bdd29e0, 0x54979a9a, 0x3eea},
      {0xe051cf9b, 0xf2767936, 0x5848},
      {0x44c24f66, 0xee382243, 0x3e23},
      {0xe3935e0e, 0x7db1a11b, 0x48f4},
      {0x5ce20cba, 0x1c6eb17f, 0x61c0},
      {0x6da25c49, 0xefac33a9, 0x3953}
    }};

    // No idea what this is. TODO.
    static constexpr storage_array<omegas_count, limbs_count> inv = {{
      {},
      {},
      {},
      {},
      {},
      {},
      {},
      {},
      {},
      {},
      {},
      {},
      {}
    }};
  };

  /**
   * Scalar field. Is always a prime field.
   */
  typedef Field<fp_config> scalar_t;
} // namespace inv_fhe79

#endif
