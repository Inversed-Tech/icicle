use icicle_core::field::{Field, MontgomeryConvertibleField};
use icicle_core::traits::{FieldConfig, FieldImpl, GenerateRandom};
use icicle_core::{impl_field, impl_scalar_field};
use icicle_cuda_runtime::device::check_device;
use icicle_cuda_runtime::device_context::DeviceContext;
use icicle_cuda_runtime::error::CudaError;
use icicle_cuda_runtime::memory::{DeviceSlice, HostOrDeviceSlice};

use ark_ff::{Fp128, MontBackend, MontConfig};

#[derive(MontConfig)]
#[modulus = "495925933090739208380417"]
#[generator = "3"]
pub struct Fq79Config;

/// The modular field used for polynomial coefficients, with precomputed primes and generators.
pub type Fq79 = Fp128<MontBackend<Fq79Config, 2>>;


pub(crate) const SCALAR_LIMBS: usize = 4;

impl_scalar_field!("inv_fhe79", inv_fhe79, SCALAR_LIMBS, ScalarField, ScalarCfg, Fq79);

#[cfg(test)]
mod tests {
    use super::ScalarField;
    use icicle_core::impl_field_tests;
    use icicle_core::tests::*;

    impl_field_tests!(ScalarField);
}
