#%%
# Prime modulus.
q = 495925933090739208380417
assert 2**78 < q < 2**79
assert q - 1 == 2**13 * 23 * 271 * 9712471302621631

# Primitive root of unity.
omega = pow(3, 23 * 271 * 9712471302621631, q)
assert omega == 460543614695341080498621
assert pow(omega, 2**13, q) == 1
assert pow(omega, 2**12, q) != 1

# Generate config for icicle.

def format_num(n, w=32):
    limbs = []
    while n != 0:
        limb = n & (2**w-1)
        limbs.append(f"0x{limb:x}")
        n >>= w
    return "{" + ", ".join(limbs) + "};"

limb_count = 4  # 3 limbs of 32 bits, padded to 4.

print("q", q, format_num(q))
print("limb_count", limb_count)
print()
print("modulus", format_num(q))
print("modulus_2", format_num(q * 2))
print("modulus_4", format_num(q * 4))
print()
print("modulus_squared", format_num(q * q))
print("modulus_squared_2", format_num(q * q * 2))
print("modulus_squared_4", format_num(q * q * 4))
print()
print("neg_modulus", format_num(2**(32 * limb_count) - q))
print()
print(f"omega", format_num(omega))
for logn in range(1, 14):
    omega_i = pow(omega, 2**(13 - logn), q)
    print(f"omega_{logn}", format_num(omega_i))
    x = pow(omega_i, 2**logn, q)
    assert x == 1
print()
for logn in range(1, 14):
    omega_i = pow(omega, 2**(13 - logn), q)
    omega_inv_i = pow(omega_i, q - 2, q)
    print(f"omega_inv_{logn}", format_num(omega_inv_i))
print()

def montgomery_neg_inv(q, w=32):
    q0 = q % (2**w)
    inv = 1
    for i in range(w - 1):
        inv = (inv * inv) % (2**w)
        inv = (inv * q) % (2**w)
    return 2**w - inv

r = 2**(32 * limb_count) % q
r_inv = pow(r, q - 2, q)
mont_neg_inv_32 = montgomery_neg_inv(q, w=32)
mont_neg_inv_64 = montgomery_neg_inv(q, w=64)
assert montgomery_neg_inv(q, w=64) == 13426823977581207551 # Validate against ark_ff value.
print("montgomery_r", r, format_num(r))
print("montgomery_r_inv", r_inv, format_num(r_inv))
print("montgomery_neg_inv_32", format_num(mont_neg_inv_32))
print("montgomery_neg_inv_64", format_num(mont_neg_inv_64, w=64))
print()

# From https://github.com/ingonyama-zk/modular_multiplication/blob/b6872e611961ef3a3e42f8903b0834a9c0b6f99c/domb_barrett_mp.py#L65
n = len(bin(q)[2:])
w = 32
k = limb_count # ceil(n / w)
z = k * w - n
m, _ = divmod(2 ** (2 * n + z), q)
m -= 1 << (k * w)
num_red = 4 + k / (2 ** z)
print(f"barrett_m={m}", format_num(m))
print(f"barrett_num_red={num_red}")
print()
