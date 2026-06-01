#include <iostream>
#include <vector>
#include <iomanip>
#include <cstdint>

class FastStreamHasher {
public:
    // 64-bit FNV-1a constants
    static constexpr uint64_t FNV_OFFSET_BASIS = 0xcbf29ce484222325ULL;
    static constexpr uint64_t FNV_PRIME = 0x100000001b3ULL;

    static uint64_t hash_stream(std::istream& stream) {
        // 4MB buffer: Maximizes pipe throughput without wasting RAM
        const size_t BUFFER_SIZE = 4 * 1024 * 1024;
        std::vector<char> buffer(BUFFER_SIZE);
        uint64_t hash_value = FNV_OFFSET_BASIS;

        while (stream) {
            stream.read(buffer.data(), BUFFER_SIZE);
            std::streamsize bytes_read = stream.gcount();
            
            if (bytes_read == 0) break;

            const uint8_t* data = reinterpret_cast<const uint8_t*>(buffer.data());
            
            for (std::streamsize i = 0; i < bytes_read; ++i) {
                hash_value ^= data[i];
                hash_value *= FNV_PRIME;
            }
        }

        return hash_value;
    }
};

int main() {
    // Performance optimization: disconnects C++ streams from C streams
    // This dramatically speeds up std::cin reading operations.
    std::freopen(nullptr, "rb", stdin);
    std::ios_base::sync_with_stdio(false);
    std::cin.tie(NULL);

    try {
        // Read directly from standard input (the pipe)
        uint64_t result = FastStreamHasher::hash_stream(std::cin);
        
        // Output the 64-bit hash as a 16-character hex string
        std::cout << std::hex << std::setfill('0') << std::setw(16) << result << std::dec << "\n";
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << "\n";
        return 1;
    }

    return 0;
}