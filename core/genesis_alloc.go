// Copyright 2017 The go-ethereum Authors
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

package core

// Constants containing the genesis allocation of built-in genesis blocks.
// Their content is an RLP-encoded list of (address, balance) tuples.
// Use mkalloc.go to create/update them.

// nolint: misspell
const mainnetAllocData = "\xe1\xe0\x94u\xf6\xc1\x9f\xc2*\xae\x15\xe4C\u0114\xce|\xd4B\xd1!\xd8u\x8a\xc0TT\xc6\xc5C\x17(\x00\x00"
const testnetAllocData = "\xe3\xe2\x94\x1e\x96\x92:\xd2#u\xd2\xd2\xff$\xd3\u0263\xb1\xa1\x01f\xf6\b\x8c\x03;.r\u055a.\x00\x00\x00\x00\x00"
