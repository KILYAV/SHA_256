#pragma once

#include <array>
#include <string>

namespace KILYAV {
	class SHA256 {
		static std::array<uint8_t,32> ImplBin(
			const char* in,
			unsigned size
			);
		static std::array<char, 64> ImplHex(
			const char* in,
			unsigned size
		);
	public:
		static std::array<uint8_t, 32> Bin(const std::string& in) {
			return ImplBin(in.data(), in.size());
		}
		static std::array<char, 64> Hex(const std::string& in) {
			return ImplHex(in.data(), in.size());
		}
	};
}
