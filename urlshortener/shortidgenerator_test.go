package urlshortener

import (
	"github.com/stretchr/testify/assert"
	"sort"
	"testing"
)

func TestGenerator(t *testing.T) {

	for i := 0; i < 10; i++ {

		gen := DefaultShortIdGenerator{}
		shortIds := []string{
			gen.Generate(VERY_SHORT),
			gen.Generate(SHORT),
			gen.Generate(MEDIUM),
			gen.Generate(VERY_LONG),
		}

		compareLengths := func(i, j int) bool {
			left := shortIds[i]
			right := shortIds[j]
			return len(right) > len(left)
		}

		sorted := sort.SliceIsSorted(shortIds, compareLengths)

		assert.True(t, sorted, "Expected VERY_SHORT, SHORT, MEDIUM, VERY_LONG. Got %v", shortIds)
	}
}