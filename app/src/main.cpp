#include <array>
std::array<int, 4> test{};
volatile int glob;

extern "C" int main() {
    glob = test[1];
    // Inifinity loop for now
    while (true) {
        __asm__("nop");
    }

    return 0;
}
