// Copyright 2015 The go-ethereum Authors
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

package params

// MainnetBootnodes are the enode URLs of the P2P bootstrap nodes running on
// the main Ethereum network.
var MainnetBootnodes = []string{
	// Ethereum Foundation Go Bootnodes
	"enode://a2dc3fe39384c7fc20822b6755d44dc50bf1288cfd6a8fc823fa8599b33590ecd47a90cab3e611c6d7e97180914bb74858a581cab1ebaa3934ce2bcd95e82d6f@47.245.25.24:17575",
	"enode://6157335ebf0e50f413dbb95d8238fa5e220b8dec4365b7bfdfb1a45d7de9dc5d9607f09390351f5878a9b298340c58ae55b4a1a8c97f97e163b23638e894bf1d@47.74.242.199:17575",
	"enode://7fbf2a2a9d26d47266fa88134a4a4d2385b7b27f04bd62d50a4f7a0bde7da0b453e0bec95d295426ec04031a67b3c81cc8e033f5c032c6619635f0fd813dbc8d@8.210.225.63:30303",
	"enode://a725997253ff7586b10c79c88200244c026bd7f8f1149f782e00439cf47358b8806d64ba3bf54e386d193076d0c8861fb4070940c5a45e838be4045a3a3d2d35@8.210.255.140:30303",
}

// TestnetBootnodes are the enode URLs of the P2P bootstrap nodes running on the
// Ropsten test network.
var TestnetBootnodes = []string{}

// DiscoveryV5Bootnodes are the enode URLs of the P2P bootstrap nodes for the
// experimental RLPx v5 topic-discovery network.
var DiscoveryV5Bootnodes = []string{}
