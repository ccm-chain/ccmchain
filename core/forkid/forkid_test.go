// Copyright 2019 The go-ethereum Authors
// This file is part of the go-ethereum library.
//
// The go-ethereum library is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// The go-ethereum library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with the go-ethereum library. If not, see <http://www.gnu.org/licenses/>.

package forkid

import (
	"bytes"
	"math"
	"testing"

	"github.com/ccm-chain/ccmchain/common"
	"github.com/ccm-chain/ccmchain/params"
	"github.com/ccm-chain/ccmchain/rlp"
)

// TestCreation tests that different genesis and fork rule combinations result in
// the correct fork ID.
func TestCreation(t *testing.T) {
	type testcase struct {
		head uint64
		want ID
	}
	tests := []struct {
		config  *params.ChainConfig
		genesis common.Hash
		cases   []testcase
	}{
		// Mainnet test cases
		{
			params.MainnetChainConfig,
			params.MainnetGenesisHash,
			[]testcase{
				{0, ID{Hash: checksumToBytes(0x92e789d0), Next: 0}},       // Unsynced
				{1149999, ID{Hash: checksumToBytes(0x92e789d0), Next: 0}}, // Last Frontier block
				{1150000, ID{Hash: checksumToBytes(0x92e789d0), Next: 0}}, // First Homestead block
				{1919999, ID{Hash: checksumToBytes(0x92e789d0), Next: 0}}, // Last Homestead block
				{4370000, ID{Hash: checksumToBytes(0x92e789d0), Next: 0}}, // First Byzantium block
				{7279999, ID{Hash: checksumToBytes(0x92e789d0), Next: 0}}, // Last Byzantium block
				{7280000, ID{Hash: checksumToBytes(0x92e789d0), Next: 0}}, // First and last Constantinople, first Petersburg block
				{7987396, ID{Hash: checksumToBytes(0x92e789d0), Next: 0}}, // Today Petersburg block
				{1769535, ID{Hash: checksumToBytes(0x92e789d0), Next: 0}}, // Today block
			},
		},
		// Ropsten test cases
		{
			params.TestnetChainConfig,
			params.TestnetGenesisHash,
			[]testcase{
				{0, ID{Hash: checksumToBytes(0x12edcbe4), Next: 0}},       // Unsynced, last Frontier, Homestead and first Tangerine block
				{9, ID{Hash: checksumToBytes(0x12edcbe4), Next: 0}},       // Last Tangerine block
				{10, ID{Hash: checksumToBytes(0x12edcbe4), Next: 0}},      // First Spurious block
				{1699999, ID{Hash: checksumToBytes(0x12edcbe4), Next: 0}}, // Last Spurious block
				{1700000, ID{Hash: checksumToBytes(0x12edcbe4), Next: 0}}, // First Byzantium block
				{4229999, ID{Hash: checksumToBytes(0x12edcbe4), Next: 0}}, // Last Byzantium block
				{4230000, ID{Hash: checksumToBytes(0x12edcbe4), Next: 0}}, // First Constantinople block
				{4939393, ID{Hash: checksumToBytes(0x12edcbe4), Next: 0}}, // Last Constantinople block
				{4939394, ID{Hash: checksumToBytes(0x12edcbe4), Next: 0}}, // First Petersburg block
				{5822692, ID{Hash: checksumToBytes(0x12edcbe4), Next: 0}}, // Today Petersburg block
			},
		},
	}
	for i, tt := range tests {
		for j, ttt := range tt.cases {
			if have := NewID(tt.config, tt.genesis, ttt.head); have != ttt.want {
				t.Errorf("test %d, case %d: fork ID mismatch: have %x, want %x", i, j, have, ttt.want)
			}
		}
	}
}

// Tests that IDs are properly RLP encoded (specifically important because we
// use uint32 to store the hash, but we need to encode it as [4]byte).
func TestEncoding(t *testing.T) {
	tests := []struct {
		id   ID
		want []byte
	}{
		{ID{Hash: checksumToBytes(0), Next: 0}, common.Hex2Bytes("c6840000000080")},
		{ID{Hash: checksumToBytes(0xdeadbeef), Next: 0xBADDCAFE}, common.Hex2Bytes("ca84deadbeef84baddcafe,")},
		{ID{Hash: checksumToBytes(math.MaxUint32), Next: math.MaxUint64}, common.Hex2Bytes("ce84ffffffff88ffffffffffffffff")},
	}
	for i, tt := range tests {
		have, err := rlp.EncodeToBytes(tt.id)
		if err != nil {
			t.Errorf("test %d: failed to encode forkid: %v", i, err)
			continue
		}
		if !bytes.Equal(have, tt.want) {
			t.Errorf("test %d: RLP mismatch: have %x, want %x", i, have, tt.want)
		}
	}
}
